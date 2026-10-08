#!/usr/bin/env bash
# Live-state verification for the "create ECK entity type `country` + bundle `sovereign`"
# task. Prints PASS/FAIL with detail, exits 0 (pass) / 1 (fail). No arguments.
# Checks, against the running site:
#   cfg    — eck_entity_type config `country` exists with Title + Status base fields on
#   reg    — the dynamic content entity type `country` is registered
#   table  — its base table `country` exists in the DB
#   bundle — bundle config `eck.eck_type.country.sovereign` exists
#   breg   — `sovereign` is a registered bundle of `country`
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $type = \Drupal\eck\Entity\EckEntityType::load("country");
  $cfg = $type && $type->hasTitleField() && $type->hasStatusField();
  $reg = (bool) \Drupal::entityTypeManager()->getDefinition("country", FALSE);
  $table = \Drupal::database()->schema()->tableExists("country");
  $bundle = (bool) \Drupal::config("eck.eck_type.country.sovereign")->get("type");
  $binfo = \Drupal::service("entity_type.bundle.info")->getBundleInfo("country");
  $breg = isset($binfo["sovereign"]);
  $ok = $cfg && $reg && $table && $bundle && $breg;
  print ($ok ? "PASS" : "FAIL") . " cfg=" . ($cfg?1:0) . " reg=" . ($reg?1:0)
    . " table=" . ($table?1:0) . " bundle=" . ($bundle?1:0) . " breg=" . ($breg?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
