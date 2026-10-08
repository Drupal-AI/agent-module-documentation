#!/usr/bin/env bash
# Introspection SETUP (views_ical M1): create a view 'vical_wizard' with an iCal display whose
# Format is the iCal Style Wizard (style plugin 'ical_wizard'). The agent must inspect the live
# view config to report the style plugin id. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if (!View::load("vical_wizard")) {
    View::create([
      "id" => "vical_wizard", "label" => "Vical Wizard", "base_table" => "node_field_data",
      "display" => [
        "default" => ["display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,"display_options"=>["title"=>"Vical Wizard"]],
        "ical_1" => ["display_plugin"=>"ical","id"=>"ical_1","display_title"=>"iCal","position"=>1,
          "display_options"=>["path"=>"vical-wizard","style"=>["type"=>"ical_wizard"],"row"=>["type"=>"ical_fields_wizard"],"filename"=>""]],
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vical_wizard has an iCal display using style ical_wizard + row ical_fields_wizard"
