#!/usr/bin/env bash
# Introspection SETUP: configure allow_iframed_site to remove X-Frame-Options on known paths so an
# agent can read which paths are allowed to be iframed. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::service("plugin.manager.condition")->createInstance("request_path");
  $c->setConfiguration(["pages"=>"/aisframe-demo\n/aisframe-demo/*","negate"=>FALSE]);
  \Drupal::configFactory()->getEditable("allow_iframed_site.settings")->set("request_path", $c->getConfiguration())->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: allow_iframed_site allows framing of /aisframe-demo and /aisframe-demo/*"
