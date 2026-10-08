#!/usr/bin/env bash
# Execution CLEANUP: restore core's Content search as the enabled default page and remove
# the se_swap search page plus se_swap_type content type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  // Guard: domain_source/domain_access attach a field to every NEW node type, and their
  // field storages are purged when the last bundle instance goes away. Re-install their
  // default config (idempotent) so creating/deleting a content type below cannot fail.
  foreach (["domain_source", "domain_access"] as $m) {
    if (\Drupal::moduleHandler()->moduleExists($m)) {
      \Drupal::service("config.installer")->installDefaultConfig("module", $m);
    }
  }
' >/dev/null 2>&1
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\search\Entity\SearchPage;
  \Drupal::configFactory()->getEditable("search.settings")->set("default_page", "node_search")->save();
  if ($n = SearchPage::load("node_search")) { $n->enable()->save(); }
  if ($p = SearchPage::load("se_swap")) { $p->delete(); }
  if ($t = NodeType::load("se_swap_type")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
# Restore the domain_* field storages that deleting a content type may have purged, so the
# shared site is left able to create content types again.
drush php:eval '
  foreach (["domain_source", "domain_access"] as $m) {
    if (\Drupal::moduleHandler()->moduleExists($m)) {
      \Drupal::service("config.installer")->installDefaultConfig("module", $m);
    }
  }
' >/dev/null 2>&1
echo "cleanup: node_search re-enabled as default; se_swap and se_swap_type removed"
