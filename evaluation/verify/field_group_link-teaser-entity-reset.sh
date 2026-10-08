#!/usr/bin/env bash
# Execution RESET: prepare a namespaced Article view mode "fgl_teaser" with the string field
# field_fgl_teaser_text as a plain component, and strip ANY field_group groups from the
# display — so verify FAILS until the agent creates a field_group_link group that links the
# group at the node's own page. Idempotent. Exit 0.
#
# The "clear groups" write is confirmed from a SEPARATE drush bootstrap and retried, because
# on a busy site a config save can be lost to a lock deadlock while still looking applied
# inside the writing request.
set -uo pipefail
cd /var/www/html

# Step 1: the view mode and the field. Kept separate so a hiccup here cannot abort step 2.
drush php:eval '
  use Drupal\Core\Entity\Entity\EntityViewMode;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  if (!EntityViewMode::load("node.fgl_teaser")) {
    EntityViewMode::create([
      "id" => "node.fgl_teaser", "targetEntityType" => "node", "label" => "FGL Teaser",
    ])->save();
  }
  if (!FieldStorageConfig::loadByName("node", "field_fgl_teaser_text")) {
    FieldStorageConfig::create([
      "field_name" => "field_fgl_teaser_text", "entity_type" => "node", "type" => "string",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fgl_teaser_text")) {
    FieldConfig::create([
      "field_name" => "field_fgl_teaser_text", "entity_type" => "node", "bundle" => "article",
      "label" => "FGL Teaser Text",
    ])->save();
  }
' >/dev/null 2>&1

# Step 2: create/clean the view display, re-checking from a fresh bootstrap each round.
state="unknown:x"
for _ in 1 2 3; do
  drush php:eval '
    $s = \Drupal::entityTypeManager()->getStorage("entity_view_display");
    $vd = $s->load("node.article.fgl_teaser") ?: $s->create([
      "targetEntityType" => "node", "bundle" => "article", "mode" => "fgl_teaser", "status" => TRUE,
    ]);
    $vd->setStatus(TRUE);
    $vd->setComponent("field_fgl_teaser_text", ["type" => "string", "label" => "hidden", "weight" => 1, "region" => "content"]);
    foreach (array_keys($vd->getThirdPartySettings("field_group")) as $g) {
      $vd->unsetThirdPartySetting("field_group", $g);
    }
    $vd->save();
  ' >/dev/null 2>&1
  drush cr >/dev/null 2>&1
  state=$(drush php:eval '
    $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.fgl_teaser");
    print ($vd ? "present:" . count($vd->getThirdPartySettings("field_group")) : "MISSING:x");
  ' 2>/dev/null)
  [ "$state" = "present:0" ] && break
done
echo "reset: node.article.fgl_teaser display=${state%%:*} field_group_groups=${state##*:} (want present:0)"
