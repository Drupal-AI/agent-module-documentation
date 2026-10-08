#!/usr/bin/env bash
# Execution RESET: make sure the content type se_task_type exists and that NO search page
# named se_task exists, so the verify below fails on empty state. Idempotent. Exit 0.
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
  if (!NodeType::load("se_task_type")) {
    NodeType::create(["type" => "se_task_type", "name" => "SE Task Type"])->save();
  }
  if ($p = SearchPage::load("se_task")) { $p->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: se_task_type present, search page se_task removed"
