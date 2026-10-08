#!/usr/bin/env bash
# Introspection SETUP (views_ical M2): create a view 'vical_named' whose iCal display sets a
# custom download filename ('calendar.ics') via the ical display plugin's filename option. The
# agent must read the live view config to report the filename. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if (!View::load("vical_named")) {
    View::create([
      "id" => "vical_named", "label" => "Vical Named", "base_table" => "node_field_data",
      "display" => [
        "default" => ["display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,"display_options"=>["title"=>"Vical Named"]],
        "ical_1" => ["display_plugin"=>"ical","id"=>"ical_1","display_title"=>"iCal","position"=>1,
          "display_options"=>["path"=>"vical-named","style"=>["type"=>"ical_wizard"],"row"=>["type"=>"ical_fields_wizard"],"filename"=>"calendar.ics"]],
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vical_named iCal display filename = calendar.ics"
