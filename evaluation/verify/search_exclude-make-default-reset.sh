#!/usr/bin/env bash
# Execution RESET: create content type se_swap_type and a search page se_swap that uses the
# search_exclude plugin but excludes nothing; restore core's Content search (node_search)
# as the enabled site default. Verify below therefore fails on this state. Idempotent. Exit 0.
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
  if (!NodeType::load("se_swap_type")) {
    NodeType::create(["type" => "se_swap_type", "name" => "SE Swap Type"])->save();
  }
  if ($p = SearchPage::load("se_swap")) { $p->delete(); }
  SearchPage::create([
    "id" => "se_swap", "label" => "SE Swap", "path" => "se-swap",
    "plugin" => "search_exclude_node_search", "status" => TRUE, "weight" => 13,
    "configuration" => ["excluded_bundles" => [], "rankings" => []],
  ])->save();
  if ($n = SearchPage::load("node_search")) { $n->enable()->save(); }
  \Drupal::configFactory()->getEditable("search.settings")->set("default_page", "node_search")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: se_swap exists with no exclusions; node_search enabled and is the default page"
