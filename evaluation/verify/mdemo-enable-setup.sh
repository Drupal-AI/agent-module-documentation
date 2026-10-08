#!/usr/bin/env bash
# Introspection SETUP: purge any leftover demo Search API index/server (so install won't collide),
# install monitoring_demo, then immediately restore the site front page to /node (the demo changes it).
# Baseline uninstalled; cleanup uninstalls + tidies. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'try { foreach (["demo"] as $iid) { if ($x = \Drupal::entityTypeManager()->getStorage("search_api_index")->load($iid)) { $x->delete(); } } } catch (\Throwable $e) {} try { foreach (["demo"] as $sid) { if ($x = \Drupal::entityTypeManager()->getStorage("search_api_server")->load($sid)) { $x->delete(); } } } catch (\Throwable $e) {}' >/dev/null 2>&1
drush pm:install monitoring_demo -y >/dev/null 2>&1
drush php:eval '\Drupal::configFactory()->getEditable("system.site")->set("page.front", "/node")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: monitoring_demo installed; page.front restored to /node"
