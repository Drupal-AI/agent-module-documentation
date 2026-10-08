#!/usr/bin/env bash
# Introspection SETUP: create a content_moderation workflow 'gcmod_editorial'. A content_moderation
# workflow ships default states (draft, published) and transitions (create_new_draft, publish), so
# gcontent_moderation exposes the group permission 'use gcmod_editorial transition publish'.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\workflows\Entity\Workflow;
  if (!Workflow::load("gcmod_editorial")) {
    Workflow::create(["id" => "gcmod_editorial", "label" => "GCmod Editorial", "type" => "content_moderation"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: workflow gcmod_editorial (default content_moderation transitions incl. publish)"
