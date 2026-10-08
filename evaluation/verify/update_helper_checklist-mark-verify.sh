#!/usr/bin/env bash
# Execution VERIFY (update_helper_checklist H2): PASS when the scratch file marks a module's
# updates complete via the update_helper_checklist.update_checklist service's markUpdatesSuccessful().
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
f="web/sites/default/update_helper_checklist_mark.eval.php"
if [ -f "$f" ] \
   && grep -q "update_helper_checklist.update_checklist" "$f" \
   && grep -q "markUpdatesSuccessful" "$f"; then
  echo "PASS: $f marks updates via update_helper_checklist.update_checklist->markUpdatesSuccessful()"
  exit 0
fi
echo "FAIL: $f missing or does not call markUpdatesSuccessful() on update_helper_checklist.update_checklist"
exit 1
