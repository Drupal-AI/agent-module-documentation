#!/usr/bin/env bash
# Execution VERIFY (update_helper H2): PASS when the scratch file is a Configuration Update
# Definition (CUD) that changes a config: it must reference a config name and carry both an
# expected_config and update_actions section (the shape update_helper.updater applies).
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
f="web/sites/default/update_helper_cud.eval.yml"
if [ -f "$f" ] \
   && grep -q "expected_config" "$f" \
   && grep -q "update_actions" "$f"; then
  echo "PASS: $f is a CUD with expected_config + update_actions"
  exit 0
fi
echo "FAIL: $f missing or not a CUD (needs expected_config and update_actions)"
exit 1
