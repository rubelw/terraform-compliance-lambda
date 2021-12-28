import json

import os, tempfile, json
import subprocess
import re
from io import StringIO
import contextlib
import sys

from tempfile import mkdtemp
from git import Repo
from terraform_compliance import __app_name__, __version__
from terraform_compliance.common.readable_dir import ReadableDir
from terraform_compliance.common.readable_plan import ReadablePlan
from radish.main import main as call_radish
from radish.utils import console_write
from radish.loader import load_module
from terraform_compliance.common.defaults import Defaults
from terraform_compliance.common.helper import python_version_check
import io
from contextlib import redirect_stdout, contextmanager
from collections import OrderedDict

#
# This is used to override some stuff that does not fit our needs within radish-bdd.
# Better not to touch anything here.
from terraform_compliance.extensions.override_radish_step import Step as StepOverride
from radish.stepmodel import Step
Step.run = StepOverride.run

from terraform_compliance.extensions.override_radish_hookerrors import handle_exception as handle_exception_override
from radish import errororacle
errororacle.handle_exception = handle_exception_override


if __version__ == "{{VERSION}}":
    __version__ = "\blocal development version"
print('{} v{} initiated\n'.format(__app_name__, Defaults().yellow(__version__)))



def lambda_handler(event, context):
    # TODO implement
    print("Event: %s" % json.dumps(event))
    print('cwd: '+str(os.getcwd()))

    if 'path' in event:
        print('has path')
        path = event['path']

        if 'httpMethod' in event:
            print('has httpMethod')
            method = event['httpMethod']

            if path == '/version':
                print('path is /version')
                if method == 'GET':
                    print('method is GET')

                    print('Returning response')
                    results = [{
                        "version": str(__version__)
                    }]

                    return {
                        'statusCode': 200,
                        'headers': {
                            "Access-Control-Allow-Headers": "Content-Type",
                            "Access-Control-Allow-Methods": "OPTIONS,POST,GET"
                        },
                        'body': json.dumps( results)
                    }
                else:
                    return {
                        'statusCode': 200,
                        'headers': {
                            "Access-Control-Allow-Headers": "Content-Type",
                            "Access-Control-Allow-Methods": "OPTIONS,POST,GET"
                        },
                        'body': json.dumps('Must use a GET on path /version')
                    }

            elif path == '/summary':
                print('has /summary')
                if method == 'POST':
                    print('is POST')
                    content = json.loads(event['body'])

                    tags = None

                    if 'queryStringParameters' in event and event['queryStringParameters']:

                        if 'tags' in event['queryStringParameters'] and event['queryStringParameters']['tags']:
                            tags = event['queryStringParameters']['tags']

                    print('content: ' + str(content))
                    directory_name = tempfile.mkdtemp()
                    input_filename = str(directory_name) + '/tfplan.json'

                    print('inputfile: '+str(input_filename))
                    try:

                        with open(input_filename, "w") as outfile:
                            json.dump(content, outfile)

                        steps_directory = '/var/task/terraform_compliance/steps'
                        features_directory = '/var/task/features'
                        terraform_binary = '/var/task/terraform'

                        print('running terraform compliance')

                        if tags:
                            command = '/var/task/myterraform-compliance --cucumber-json=/tmp/output.json -t ' + str(
                                terraform_binary) + ' -f ' + str(features_directory) + ' --tags '+str(tags)+' -p ' + str(input_filename)
                        else:
                            command = '/var/task/myterraform-compliance --cucumber-json=/tmp/output.json -t ' + str(
                                terraform_binary) + ' -f ' + str(features_directory) + ' -p ' + str(input_filename)
                        process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
                        proc_stdout, proc_stderr = process.communicate(timeout=120)
                        print(str(proc_stdout))
                        print(str(proc_stderr))


                        with open('/tmp/output.json') as f:
                            data = json.load(f)
                        print(str(data))

                        passed = 0
                        failed = 0
                        skipped = 0
                        for item in data:
                            for element in item['elements']:
                                for step in element['steps']:
                                    if step['result']['status'] == 'passed':
                                        passed = passed + 1
                                    elif step['result']['status'] == 'skipped':
                                        skipped = skipped + 1
                                    else:
                                        failed = failed + 1

                        info = {}
                        info['results'] = data
                        info['summary'] = {}
                        info['summary']['passed_step_count'] = passed
                        info['summary']['failed_step_count'] = failed
                        info['summary']['skipped_step_count'] = skipped


                        if failed > 0:
                            info['summary']['overall_status'] = 'Failed'
                        else:
                            info['summary']['overall_status'] = 'Passed'

                        return {
                            'statusCode': 200,
                            'headers': {
                                "Access-Control-Allow-Headers": "Content-Type",
                                "Access-Control-Allow-Methods": "OPTIONS,POST,GET"
                            },
                            'body': json.dumps(info)
                        }

                    except:
                        e = sys.exc_info()[0]
                        print('Something went wrong: ' + str(e))
                        os.system("/bin/rm -rf " + str(directory_name))

                        return {
                            'statusCode': 200,
                            'headers': {
                                "Access-Control-Allow-Headers": "Content-Type",
                                "Access-Control-Allow-Methods": "OPTIONS,POST,GET"
                            },
                            'body': json.dumps('Error Posting!'+str(e))
                        }

                else:
                    return {
                        'statusCode': 200,
                        'headers': {
                            "Access-Control-Allow-Headers": "Content-Type",
                            "Access-Control-Allow-Methods": "OPTIONS,POST,GET"
                        },
                        'body': json.dumps('Must use a POST on /summary with tfplan in the body of the message.')
                    }

    cwd = os.getcwd()
    dirlist = os.listdir(cwd)


    return {
        'statusCode': 200,
        'body': json.dumps('Must enter terraform plan!')
    }
