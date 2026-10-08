#!/usr/bin/env bash
# Execution RESET for "hide the WHOLE revision tab on the Article node form". Forces the
# WRONG baseline (field visible, tab shown): node.article.default revision_log widget
# show=TRUE, hide_revision=FALSE. The agent must set show=FALSE AND hide_revision=TRUE.
# Idempotent. Rebuilds caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  if ($fd) {
    $c = $fd->getComponent("revision_log");
    if (is_array($c)) {
      $c["settings"]["show"] = TRUE;
      $c["settings"]["hide_revision"] = FALSE;
      $fd->setComponent("revision_log", $c)->save();
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article revision_log show=TRUE hide_revision=FALSE (revision tab visible)"
