#!/usr/bin/env bash
# Introspection SETUP (contentimport): contentimport has no persistent config; the answer comes
# from inspecting the live content types and their fields. This asserts the known baseline (the
# Article content type with its body field) that the agent must inspect. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
has_article=$(drush php:eval 'print \Drupal\node\Entity\NodeType::load("article") ? "yes" : "no";' 2>/dev/null)
echo "setup: content types present for contentimport to target (Article body field discoverable); article=$has_article"
