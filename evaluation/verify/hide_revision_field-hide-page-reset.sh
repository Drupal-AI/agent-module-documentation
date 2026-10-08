#!/usr/bin/env bash
# Execution RESET for "hide the revision log field on the Basic page content type".
# Forces the WRONG baseline (field VISIBLE) so verify FAILS until the agent hides it:
# node.page.default revision_log widget show=TRUE, hide_revision=FALSE.
# Idempotent. Rebuilds caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.page.default");
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
echo "reset: node.page revision_log show=TRUE (visible; must be hidden by the agent)"
