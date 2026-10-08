#!/usr/bin/env bash
# Live-state verification for the "create ECK entity type `venue` (Title + Author + Status
# base fields) + bundle `stadium`" task. Prints PASS/FAIL, exits 0 (pass) / 1 (fail).
# Checks, against the running site:
#   cfg    — eck_entity_type config `venue` exists with Title, Author (uid) AND Status on
#   reg    — the dynamic content entity type `venue` is registered
#   table  — its base table `venue` exists in the DB
#   bundle — bundle config `eck.eck_type.venue.stadium` exists
#   breg   — `stadium` is a registered bundle of `venue`
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $type = \Drupal\eck\Entity\EckEntityType::load("venue");
  $cfg = $type && $type->hasTitleField() && $type->hasAuthorField() && $type->hasStatusField();
  $reg = (bool) \Drupal::entityTypeManager()->getDefinition("venue", FALSE);
  $table = \Drupal::database()->schema()->tableExists("venue");
  $bundle = (bool) \Drupal::config("eck.eck_type.venue.stadium")->get("type");
  $binfo = \Drupal::service("entity_type.bundle.info")->getBundleInfo("venue");
  $breg = isset($binfo["stadium"]);
  $ok = $cfg && $reg && $table && $bundle && $breg;
  print ($ok ? "PASS" : "FAIL") . " cfg=" . ($cfg?1:0) . " reg=" . ($reg?1:0)
    . " table=" . ($table?1:0) . " bundle=" . ($bundle?1:0) . " breg=" . ($breg?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
