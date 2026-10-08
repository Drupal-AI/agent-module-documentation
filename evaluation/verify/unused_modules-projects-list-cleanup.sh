#!/usr/bin/env bash
# Execution CLEANUP: remove the um_fixture fixture directory and the projects report file. Baseline.
set -uo pipefail
cd /var/www/html
rm -rf web/modules/custom/um_fixture
rm -f web/sites/default/files/um_projects.txt
echo "cleanup: um_fixture dir + um_projects.txt removed"
