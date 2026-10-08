#!/usr/bin/env bash
# Execution CLEANUP: remove the um_fixture fixture directory and the report file. Restores baseline.
set -uo pipefail
cd /var/www/html
rm -rf web/modules/custom/um_fixture
rm -f web/sites/default/files/um_report.txt
echo "cleanup: um_fixture dir + um_report.txt removed"
