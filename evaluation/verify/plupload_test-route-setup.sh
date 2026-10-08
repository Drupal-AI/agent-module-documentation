#!/usr/bin/env bash
# Introspection SETUP: nothing to write — the fact under test is that the demo submodule is
# enabled and its route plupload.test (/plupload-test) is registered with open access. Ensure
# the module is enabled so the route exists. Exit 0.
set -uo pipefail
cd /var/www/html
if ! drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx plupload_test; then
  drush en plupload_test -y >/dev/null 2>&1
fi
echo "setup: plupload_test enabled; route plupload.test at /plupload-test present"
