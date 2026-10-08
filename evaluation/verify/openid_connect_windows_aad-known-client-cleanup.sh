#!/usr/bin/env bash
# Introspection CLEANUP: delete the known eval_entra openid_connect_client config entity,
# restoring baseline (no such client ships by default). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::entityTypeManager()->getStorage("openid_connect_client")->load("eval_entra");
  if ($c) { $c->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: openid_connect_client eval_entra removed"
