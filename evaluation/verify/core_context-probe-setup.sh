#!/usr/bin/env bash
# Introspection SETUP: attach a core_context context (via third-party settings) to the
# node.article.default entity_view_display so an agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $d->setThirdPartySetting("core_context", "contexts", [
    "cc_probe" => ["type" => "string", "label" => "CC Probe", "description" => "", "value" => "probe-value-42"],
  ]);
  $d->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article.default has core_context context cc_probe (value probe-value-42)"
