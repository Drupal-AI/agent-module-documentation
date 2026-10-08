#!/usr/bin/env bash
# Introspection SETUP: create paragraph types so_on (style_options behavior ENABLED) and so_off
# (behavior NOT enabled), so an agent can tell which one has Style Options. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  $on = ParagraphsType::load("so_on") ?: ParagraphsType::create(["id" => "so_on", "label" => "SO On"]);
  $on->save();
  $on->getBehaviorPlugin("style_options")->setConfiguration(["enabled" => TRUE]);
  $on->save();
  $off = ParagraphsType::load("so_off") ?: ParagraphsType::create(["id" => "so_off", "label" => "SO Off"]);
  $off->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: so_on has style_options enabled; so_off does not"
