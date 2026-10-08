#!/usr/bin/env bash
# Introspection SETUP: override the Article Title base field label to 'Headline' via core's
# BaseFieldOverride (what base_field_override_ui edits), so an agent can read it back. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Field\Entity\BaseFieldOverride;
  $def = \Drupal::service("entity_field.manager")->getBaseFieldDefinitions("node")["title"];
  $o = BaseFieldOverride::load("node.article.title") ?: BaseFieldOverride::createFromBaseFieldDefinition($def, "article");
  $o->setLabel("Headline")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: core.base_field_override.node.article.title label = Headline"
