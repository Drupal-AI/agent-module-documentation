#!/usr/bin/env bash
# Introspection CLEANUP: restore the Article node form-display revision_log widget to its
# baseline (show=TRUE, field visible), undoing the matching setup script. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  if ($fd) {
    $c = $fd->getComponent("revision_log");
    if (is_array($c)) {
      $c["settings"]["show"] = TRUE;
      $fd->setComponent("revision_log", $c)->save();
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.article revision_log widget show=TRUE (baseline restored)"
