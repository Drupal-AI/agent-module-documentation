#!/usr/bin/env bash
# Introspection CLEANUP: clear protected_urls and delete the two probe nodes. Restores the
# baseline (no extra protected paths). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("prevent_homepage_deletion.settings")
    ->set("protected_urls", "")->save();
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  foreach (["PHD Probe Alpha", "PHD Probe Beta"] as $title) {
    foreach ($storage->loadByProperties(["title" => $title]) as $node) { $node->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: protected_urls cleared and the PHD probe nodes removed"
