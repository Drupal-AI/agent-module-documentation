#!/usr/bin/env bash
# Introspection CLEANUP: unmoderate cachedmod_known, delete workflow, field and content type.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\workflows\Entity\Workflow;
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldConfig;
  if ($w = Workflow::load("cachedmod_wfk")) {
    if (in_array("cachedmod_known", $w->getTypePlugin()->getBundlesForEntityType("node"), TRUE)) {
      $w->getTypePlugin()->removeEntityTypeAndBundle("node", "cachedmod_known"); $w->save();
    }
    $w->delete();
  }
  if ($fc = FieldConfig::loadByName("node", "cachedmod_known", "cached_moderation_state")) { $fc->delete(); }
  if ($nt = NodeType::load("cachedmod_known")) { $nt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: cachedmod_known / cachedmod_wfk removed"
