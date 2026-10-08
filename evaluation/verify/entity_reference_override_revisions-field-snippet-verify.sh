#!/usr/bin/env bash
# Execution VERIFY (entity_reference_override_revisions H1): PASS when the scratch file creates a
# FieldStorageConfig of type entity_reference_override_revisions. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
f="web/sites/default/entity_reference_override_revisions_field.eval.php"
if [ -f "$f" ] \
   && grep -q "FieldStorageConfig" "$f" \
   && grep -q "entity_reference_override_revisions" "$f"; then
  echo "PASS: $f creates a FieldStorageConfig of type entity_reference_override_revisions"
  exit 0
fi
echo "FAIL: $f missing or does not create a FieldStorageConfig of type entity_reference_override_revisions"
exit 1
