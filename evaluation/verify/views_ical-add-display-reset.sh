#!/usr/bin/env bash
# Execution RESET (views_ical H2): (re)create a plain base view 'vical_base' that lists Article
# nodes with a page display but NO iCal feed display, so the agent must ADD an iCal feed to it.
# Empty (no ical) state => verify FAILS. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vical_base")) { $v->delete(); }
  View::create([
    "id" => "vical_base", "label" => "Vical Base", "base_table" => "node_field_data",
    "display" => [
      "default" => ["display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,
        "display_options"=>["title"=>"Vical Base","style"=>["type"=>"default"],"row"=>["type"=>"fields"]]],
      "page_1" => ["display_plugin"=>"page","id"=>"page_1","display_title"=>"Page","position"=>1,
        "display_options"=>["path"=>"vical-base"]],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vical_base recreated with a page display and NO iCal feed"
