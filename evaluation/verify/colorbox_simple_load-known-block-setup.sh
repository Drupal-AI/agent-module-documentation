#!/usr/bin/env bash
# Introspection SETUP: create a custom block (block_content, type basic) labelled "csl_known"
# whose body contains a colorbox-load link opening /node/1 at width=600 & height=400, so an
# inspecting agent can read the live block and report the width the lightbox will use. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block_content\Entity\BlockContent;
  $existing = \Drupal::entityTypeManager()->getStorage("block_content")->loadByProperties(["info" => "csl_known"]);
  if (!$existing) {
    BlockContent::create([
      "type" => "basic", "info" => "csl_known",
      "body" => ["value" => "<p><a class=\"colorbox-load\" href=\"/node/1?width=600&height=400\">Open in lightbox</a></p>", "format" => "basic_html"],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block_content csl_known has a colorbox-load link with width=600&height=400"
