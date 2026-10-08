#!/usr/bin/env bash
# Introspection SETUP: hide the revision log field on the Article node form by flipping the
# hide_revision_field widget's `show` setting to FALSE on core.entity_form_display.node.article.default.
# An inspecting agent should read that setting back and report the field is hidden on Article.
# Idempotent. Rebuilds caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  if ($fd) {
    $c = $fd->getComponent("revision_log");
    if (is_array($c)) {
      $c["settings"]["show"] = FALSE;
      $fd->setComponent("revision_log", $c)->save();
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article revision_log widget show=FALSE (field hidden on Article forms)"
