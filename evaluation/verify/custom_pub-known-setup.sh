#!/usr/bin/env bash
# Introspection SETUP: create a custom publishing option cpub_known (grouped under core Promotion
# options), which installs a boolean node base field named cpub_known. Lets an agent read it back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\custom_pub\Entity\CustomPublishingOption;
  if (!CustomPublishingOption::load("cpub_known")) {
    CustomPublishingOption::create([
      "id"=>"cpub_known","label"=>"Archived Known",
      "description"=>"Archive without unpublishing","publish_under_promote_options"=>TRUE,
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: custom_publishing_option cpub_known created (publish_under_promote_options=true, node field cpub_known installed)"
