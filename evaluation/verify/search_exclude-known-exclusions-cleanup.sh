#!/usr/bin/env bash
# Introspection CLEANUP: remove the search page and content type created by the setup.
# Idempotent. Exit 0.
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
  if ($p = SearchPage::load("se_known")) { $p->delete(); }
  if ($t = NodeType::load("se_known_type")) { $t->delete(); }
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
echo "cleanup: se_known search page and se_known_type content type removed"
