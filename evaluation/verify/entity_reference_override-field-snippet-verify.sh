#!/usr/bin/env bash
# Execution VERIFY (entity_reference_override H1): PASS when the scratch file is code that defines
# a field of this module's type: it must create a FieldStorageConfig AND a FieldConfig whose type
# is entity_reference_override. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
f="web/sites/default/entity_reference_override_field.eval.php"
if [ -f "$f" ] \
   && grep -q "FieldStorageConfig" "$f" \
   && grep -q "FieldConfig" "$f" \
   && grep -q '"entity_reference_override"\|'"'"'entity_reference_override'"'" "$f"; then
  echo "PASS: $f creates a FieldStorageConfig + FieldConfig of type entity_reference_override"
  exit 0
fi
echo "FAIL: $f missing or does not create a FieldStorageConfig+FieldConfig of type entity_reference_override"
exit 1
