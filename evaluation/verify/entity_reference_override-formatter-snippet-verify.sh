#!/usr/bin/env bash
# Execution VERIFY (entity_reference_override H2): PASS when the scratch file configures the
# entity_reference_override_label formatter on a view display with an override_action setting.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
f="web/sites/default/entity_reference_override_formatter.eval.php"
if [ -f "$f" ] \
   && grep -q "entity_reference_override_label" "$f" \
   && grep -q "override_action" "$f" \
   && grep -q "setComponent" "$f"; then
  echo "PASS: $f sets the entity_reference_override_label formatter with an override_action via setComponent()"
  exit 0
fi
echo "FAIL: $f missing or does not configure entity_reference_override_label with override_action (setComponent)"
exit 1
