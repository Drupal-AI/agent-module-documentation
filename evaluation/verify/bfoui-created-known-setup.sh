#!/usr/bin/env bash
# Introspection SETUP: override the Article 'created' (Authored on) base field label to
# 'Publish Date' so an agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Field\Entity\BaseFieldOverride;
  $def = \Drupal::service("entity_field.manager")->getBaseFieldDefinitions("node")["created"];
  $o = BaseFieldOverride::load("node.article.created") ?: BaseFieldOverride::createFromBaseFieldDefinition($def, "article");
  $o->setLabel("Publish Date")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: core.base_field_override.node.article.created label = Publish Date"
