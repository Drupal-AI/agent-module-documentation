#!/usr/bin/env bash
# Introspection SETUP: attach a Disqus comments field (disqus_comment) field_disqus_known to
# Article so the agent can inspect which field enables Disqus threads. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_disqus_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_disqus_known", "entity_type" => "node", "type" => "disqus_comment",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_disqus_known")) {
    FieldConfig::create([
      "field_name" => "field_disqus_known", "entity_type" => "node", "bundle" => "article",
      "label" => "Known Disqus Comments",
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_disqus_known (disqus_comment) added"
