"""
Backs up and restores a settings file to Dropbox.
This is an example app for API v2. 
"""

import sys
import argparse
import dropbox

import contextlib
import datetime
import os
import six
import time
import unicodedata

if sys.version.startswith('2'):
    input = raw_input

from dropbox.files import WriteMode
from dropbox.exceptions import ApiError, AuthError

TOKEN = ''
parser = argparse.ArgumentParser(description='UL files to Dropbox')
parser.add_argument('local', nargs='?', default='',
                    help='Local file to ul')
parser.add_argument('online', nargs='?', default='',
                    help='Online file dest')
parser.add_argument('--token', default=TOKEN,
                    help='Access token '
                    '(see https://www.dropbox.com/developers/apps)')

args = parser.parse_args()
TOKEN = args.token
ONLINEFILE = args.online
LOCALFILE = os.path.expanduser(args.local)
tot_size = os.path.getsize(LOCALFILE)
size=1194304
# Uploads contents of LOCALFILE to Dropbox
def ul():
    big_file = open(LOCALFILE, 'rb')
    uploader = client.get_chunked_uploader(big_file)
    print "uploading " + path_to_file
    while uploader.offset < file_size:  
        percent_complete = bytes_written / file_size * 100
        clearscreen()
        print "%.2f" % percent_complete + "%"
"""
    with open(LOCALFILE, 'r') as f:
        print("Uploading " + LOCALFILE + " to Dropbox as " + ONLINEFILE + "...")
        uploader = dbx.get_chunked_uploader(f, SIZE)
        while uploader.offset < SIZE:
            upload = uploader.upload_chunked(chunk_size=csize)
            print(uploader.offset)
"""
"""
        except ApiError as err:

            # This checks for the specific error where a user doesn't have
            # enough Dropbox space quota to upload this file
            if (err.error.is_path() and
                    err.error.get_path().error.is_insufficient_space()):
                sys.exit("ERROR: Cannot upload; insufficient space.")
            elif err.user_message_text:
                print(err.user_message_text)
                sys.exit()
            else:
                print(err)
                sys.exit()
"""

if __name__ == '__main__':
    # Create an instance of a Dropbox class, which can make requests to the API.
    print("Creating a Dropbox object...")
    dbx = dropbox.Dropbox(TOKEN)

    # Check that the access token is valid
    try:
        dbx.users_get_current_account()
    except AuthError as err:
        sys.exit("ERROR: Invalid access token; try re-generating an access token from the app console on the web.")

    # UPLOAD DA FILE
    ul()
    print("Done!")
