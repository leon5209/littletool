import logging
import argparse
import sys


from requests.auth import HTTPBasicAuth, HTTPDigestAuth
from requests.exceptions import RequestException

from pygerrit2.rest import GerritRestAPI

"""
this code need to work with "ansi2html" 
"""

"""
password need to be checked on the website, not the original password
"""
"""
setting log on console
"""
"""
function settings
"""

myauth = None

def _main():
    myauth = HTTPDigestAuth('account', 'password')
    rest = GerritRestAPI(url='http://code...', auth=myauth)

    try:
        """
        conditions
        """
        query = ["status:open"]
        query += ["owner:leon5209"]
        query += ["age:1week"]
        changes = rest.get("/changes/?q=%s" % "%20".join(query)) 
        logging.debug("there are %d changes", len(changes))

        """
        abandon
        """
        for change in changes:
            logging.debug("subject : %s ",change['subject'])
            logging.debug("change id : %s ",change['change_id'])

            # we don't kill draft 
            if change['status'] == "DRAFT":
                logging.debug("skip, we dont abandon draft")
            else:
                logging.debug("commit out of date , abandon!")
                rest.post("/changes/" + change['change_id'] + "/abandon",
                          json={"message": "This Commit is out of date, auto abandon! "})
        
    except RequestException as err:
        logging.error("Error: %s", str(err))

sys.exit(_main())

