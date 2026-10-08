#!/usr/bin/env bash
# Introspection SETUP: create two search pages that both use the search_exclude plugin, but
# only one of them actually excludes a content type. Idempotent. Exit 0.
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
  if (!NodeType::load("se_beta_type")) {
    NodeType::create(["type" => "se_beta_type", "name" => "SE Beta Type"])->save();
  }
  foreach (["se_alpha", "se_beta"] as $id) {
    if ($p = SearchPage::load($id)) { $p->delete(); }
  }
  SearchPage::create([
    "id" => "se_alpha", "label" => "SE Alpha", "path" => "se-alpha",
    "plugin" => "search_exclude_node_search", "status" => TRUE, "weight" => 11,
    "configuration" => ["excluded_bundles" => ["se_beta_type" => "se_beta_type"], "rankings" => []],
  ])->save();
  SearchPage::create([
    "id" => "se_beta", "label" => "SE Beta", "path" => "se-beta",
    "plugin" => "search_exclude_node_search", "status" => TRUE, "weight" => 12,
    "configuration" => ["excluded_bundles" => [], "rankings" => []],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: se_alpha excludes se_beta_type, se_beta excludes nothing"
