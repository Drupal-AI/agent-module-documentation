#!/usr/bin/env bash
# Execution RESET for "switch a feed display to Google News": (re)create view vgn_switch with a
# Feed display that uses the default RSS style/row (NOT google_news), so verify FAILS until the
# agent switches the format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vgn_switch")) { $v->delete(); }
  View::create([
    "id" => "vgn_switch", "label" => "VGN Switch", "base_table" => "node_field_data",
    "display" => [
      "default" => ["display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,
        "display_options"=>["title"=>"VGN Switch","fields"=>[]]],
      "feed_1" => ["display_plugin"=>"feed","id"=>"feed_1","display_title"=>"Feed","position"=>1,
        "display_options"=>["path"=>"vgn-switch.xml",
          "style"=>["type"=>"rss"],
          "row"=>["type"=>"rss_fields"],
          "defaults"=>["style"=>false,"row"=>false,"path"=>false]]],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vgn_switch feed display uses default rss style/row"
