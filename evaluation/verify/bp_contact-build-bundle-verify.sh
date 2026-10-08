#!/usr/bin/env bash
# Execution VERIFY (bp_contact): PASS when a paragraph bundle bpcontact_task exists and carries
# a single-value entity_reference field field_bpcontact_task whose target_type is contact_form.
# This mirrors what bp_contact ships (paragraphs_type + entity_reference -> contact_form).
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  use Drupal\paragraphs\Entity\ParagraphsType;
  $t = ParagraphsType::load("bpcontact_task");
  $fc = FieldConfig::loadByName("paragraph", "bpcontact_task", "field_bpcontact_task");
  $type = $fc ? $fc->getType() : "none";
  $sd = $fc ? $fc->getFieldStorageDefinition() : NULL;
  $target = $sd ? ($sd->getSetting("target_type") ?? "none") : "none";
  $card = $sd ? $sd->getCardinality() : 0;
  $ok = $t && $fc && $type === "entity_reference" && $target === "contact_form" && $card === 1;
  print ($ok ? "PASS" : "FAIL") . " bundle=" . ($t ? "yes" : "no") . " type=" . $type . " target=" . $target . " cardinality=" . $card . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
