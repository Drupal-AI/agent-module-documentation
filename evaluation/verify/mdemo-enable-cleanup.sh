#!/usr/bin/env bash
# Introspection CLEANUP: uninstall monitoring_demo and restore baseline: page.front=/node, demo sensors
# removed/disabled, demo Search API index/server purged. Seeded demo content nodes are intentionally
# left (harmless; see note). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall monitoring_demo -y >/dev/null 2>&1
drush php:eval 'use Drupal\monitoring\Entity\SensorConfig;
  \Drupal::configFactory()->getEditable("system.site")->set("page.front", "/node")->save();
  foreach (["node_new_page", "node_new_article"] as $s) { if ($e = SensorConfig::load($s)) { $e->delete(); } }
  if ($e = SensorConfig::load("node_new_all")) { $e->set("status", FALSE)->save(); }
  if ($e = SensorConfig::load("monitoring_installed_modules")) { $e->set("status", FALSE)->save(); }
  try { foreach (["demo"] as $iid) { if ($x = \Drupal::entityTypeManager()->getStorage("search_api_index")->load($iid)) { $x->delete(); } } } catch (\Throwable $e) {}
  try { foreach (["demo"] as $sid) { if ($x = \Drupal::entityTypeManager()->getStorage("search_api_server")->load($sid)) { $x->delete(); } } } catch (\Throwable $e) {}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: monitoring_demo uninstalled; baseline restored"
