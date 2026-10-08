#!/usr/bin/env bash
# Execution CLEANUP: unmoderate cachedmod_page, delete workflow, field and content type.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\workflows\Entity\Workflow;
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldConfig;
  foreach (["cachedmod_wfp", "cachedmod_wfk", "editorial"] as $wid) {
    if ($w = Workflow::load($wid)) {
      if (in_array("cachedmod_page", $w->getTypePlugin()->getBundlesForEntityType("node"), TRUE)) {
        $w->getTypePlugin()->removeEntityTypeAndBundle("node", "cachedmod_page"); $w->save();
      }
    }
  }
  if ($w = Workflow::load("cachedmod_wfp")) { $w->delete(); }
  if ($fc = FieldConfig::loadByName("node", "cachedmod_page", "cached_moderation_state")) { $fc->delete(); }
  $s = \Drupal::entityTypeManager()->getStorage("node");
  $ids = $s->getQuery()->accessCheck(FALSE)->condition("type", "cachedmod_page")->execute();
  if ($ids) { $s->delete($s->loadMultiple($ids)); }
  if ($nt = NodeType::load("cachedmod_page")) { $nt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: cachedmod_page / cachedmod_wfp removed (also unmoderated from editorial if agent used it)"
