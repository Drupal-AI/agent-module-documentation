#!/usr/bin/env bash
# MEDIUM introspection setup: use the config_rewrite config.rewriter service to rewrite
# the live system.site config so the site email becomes a known value the agent must read.
# Cleanup restores the admin@example.com baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $rewriter = \Drupal::service("config_rewrite.config_rewriter");
  $config = \Drupal::configFactory()->getEditable("system.site");
  $merged = $rewriter->rewriteConfig($config->getRawData(), ["mail" => "rewritten-9931@example.com"], "system.site", "config_rewrite");
  unset($merged["config_rewrite"]);
  $config->setData($merged)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: system.site mail rewritten to 'rewritten-9931@example.com' via config.rewriter"
