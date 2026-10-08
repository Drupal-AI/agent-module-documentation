#!/usr/bin/env bash
# Introspection SETUP: configure allow_iframed_site with negate ON so framing is allowed everywhere
# EXCEPT the listed path. Agent must read the config and describe it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::service("plugin.manager.condition")->createInstance("request_path");
  $c->setConfiguration(["pages"=>"/np-except","negate"=>TRUE]);
  \Drupal::configFactory()->getEditable("allow_iframed_site.settings")->set("request_path", $c->getConfiguration())->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: allow_iframed_site negate=TRUE, pages=/np-except (frame everywhere except that path)"
