#!/usr/bin/env bash
# Execution VERIFY (entity_reference_override_entity_browser H1): PASS when the scratch file
# configures a form display to use the entity_browser_entity_reference_override widget via
# setComponent(). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
f="web/sites/default/entity_reference_override_entity_browser_widget.eval.php"
if [ -f "$f" ] \
   && grep -q "entity_browser_entity_reference_override" "$f" \
   && grep -q "setComponent" "$f"; then
  echo "PASS: $f sets the entity_browser_entity_reference_override widget via setComponent()"
  exit 0
fi
echo "FAIL: $f missing or does not set the entity_browser_entity_reference_override widget (setComponent)"
exit 1
