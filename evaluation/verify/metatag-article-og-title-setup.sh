#!/usr/bin/env bash
# Introspection SETUP: create a per-bundle metatag_defaults config entity for node:article
# (id node__article) carrying a KNOWN Open Graph title (og_title) so an inspecting agent can
# read it back with drush. The node__article defaults entity does not ship by default, so it is
# safe to create/delete. Idempotent: rewrites the entity each run. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cfg = \Drupal::configFactory()->getEditable("metatag.metatag_defaults.node__article");
  $tags = $cfg->get("tags") ?: [];
  $tags["og_title"] = "[node:title] - Eval OG Article";
  $cfg->set("id", "node__article")
      ->set("label", "Content: Article")
      ->set("tags", $tags)
      ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: metatag node__article defaults created with known og:title"
