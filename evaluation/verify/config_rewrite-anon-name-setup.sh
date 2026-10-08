#!/usr/bin/env bash
# MEDIUM introspection setup: use the config_rewrite config.rewriter service to rewrite
# the live user.settings config so the anonymous display name becomes a known value.
# Cleanup restores the "Anonymous" baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $rewriter = \Drupal::service("config_rewrite.config_rewriter");
  $config = \Drupal::configFactory()->getEditable("user.settings");
  $merged = $rewriter->rewriteConfig($config->getRawData(), ["anonymous" => "Visitor 7788"], "user.settings", "config_rewrite");
  unset($merged["config_rewrite"]);
  $config->setData($merged)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: user.settings anonymous rewritten to 'Visitor 7788' via config.rewriter"
