#!/usr/bin/env bash
# Introspection SETUP: ignore a different known config (a contact form config entity) so the
# agent must read the live ignore list to answer which form stays editable under readonly.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("config_ignore.settings");
  $c->set("mode", "simple")->set("ignored_config_entities", ["contact.form.feedback"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: config_ignore.settings ignored_config_entities = [contact.form.feedback]"
