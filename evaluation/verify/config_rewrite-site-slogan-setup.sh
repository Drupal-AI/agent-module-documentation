#!/usr/bin/env bash
# MEDIUM introspection setup: use the config_rewrite config.rewriter service to rewrite
# the live system.site config so its slogan becomes a known value the agent must read back.
# Cleanup (config_rewrite-site-slogan-cleanup.sh) restores the empty baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $rewriter = \Drupal::service("config_rewrite.config_rewriter");
  $config = \Drupal::configFactory()->getEditable("system.site");
  $merged = $rewriter->rewriteConfig($config->getRawData(), ["slogan" => "Rewritten slogan 4242"], "system.site", "config_rewrite");
  unset($merged["config_rewrite"]);
  $config->setData($merged)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: system.site slogan rewritten to 'Rewritten slogan 4242' via config.rewriter"
