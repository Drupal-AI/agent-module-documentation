#!/usr/bin/env bash
# Execution RESET: ensure field_pl_switch exists on Article using the DEFAULT paragraph handler
# (default:paragraph, no limits), so verify FAILS until the agent switches it to paragraphs_limits
# and sets pl_text max=3. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\paragraphs\Entity\ParagraphsType;
  if (!ParagraphsType::load("pl_text")) { ParagraphsType::create(["id"=>"pl_text","label"=>"PL Text"])->save(); }
  if (!FieldStorageConfig::loadByName("node","field_pl_switch")) {
    FieldStorageConfig::create(["field_name"=>"field_pl_switch","entity_type"=>"node","type"=>"entity_reference_revisions","settings"=>["target_type"=>"paragraph"],"cardinality"=>-1])->save();
  }
  $fc = FieldConfig::loadByName("node","article","field_pl_switch") ?: FieldConfig::create(["field_name"=>"field_pl_switch","entity_type"=>"node","bundle"=>"article","label"=>"PL Paragraphs"]);
  $fc->setSetting("handler","default:paragraph");
  $fc->setSetting("handler_settings",["target_bundles"=>["pl_text"=>"pl_text"],"target_bundles_drag_drop"=>["pl_text"=>["weight"=>0,"enabled"=>TRUE]]]);
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_pl_switch uses default:paragraph handler (no limits)"
