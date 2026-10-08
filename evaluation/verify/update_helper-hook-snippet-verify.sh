#!/usr/bin/env bash
# Execution VERIFY (update_helper H1): PASS when the scratch file contains a correct update hook
# that applies a CUD via the update_helper.updater service: it must fetch update_helper.updater,
# call executeUpdate() and return the logger output. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
f="web/sites/default/update_helper_hook.eval.php"
if [ -f "$f" ] \
   && grep -q "update_helper.updater" "$f" \
   && grep -q "executeUpdate" "$f" \
   && grep -Eq "logger\(\)->output\(\)" "$f"; then
  echo "PASS: $f applies a CUD via update_helper.updater->executeUpdate() and returns logger()->output()"
  exit 0
fi
echo "FAIL: $f missing or does not call update_helper.updater executeUpdate() + logger()->output()"
exit 1
