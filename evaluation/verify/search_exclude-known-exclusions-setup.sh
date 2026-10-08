#!/usr/bin/env bash
# Introspection SETUP: create a content type and a core Search page that uses the
# search_exclude "Content (Exclude)" plugin with that type excluded, so an agent can read
# back which bundles are kept out of the index. Idempotent. Exit 0.
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
  if (!NodeType::load("se_known_type")) {
    NodeType::create(["type" => "se_known_type", "name" => "SE Known Type"])->save();
  }
  if ($p = SearchPage::load("se_known")) { $p->delete(); }
  SearchPage::create([
    "id" => "se_known", "label" => "SE Known (exclude)", "path" => "se-known",
    "plugin" => "search_exclude_node_search", "status" => TRUE, "weight" => 10,
    "configuration" => ["excluded_bundles" => ["se_known_type" => "se_known_type"], "rankings" => []],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: search page se_known (search_exclude_node_search) excludes se_known_type"
