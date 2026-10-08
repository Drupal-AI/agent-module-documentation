#!/usr/bin/env bash
# Introspection SETUP: relabel the Tweet media type's source field so the agent must read the
# live field configuration rather than reciting the default. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal\field\Entity\FieldConfig::loadByName("media", "tweet", "embed_code");
  $f->set("label", "LM Tweet URL")->save();
' >/dev/null 2>&1
echo "setup: field.field.media.tweet.embed_code label='LM Tweet URL'"
