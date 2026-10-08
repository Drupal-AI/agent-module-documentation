#!/usr/bin/env bash
# Introspection SETUP: create a View vgn_probe with a Feed display that uses the Google News
# style (google_news) + row (google_news_fields), with loc_field mapped to 'view_node', so an
# agent can inspect the live view config and read the plugin ids / field mapping. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vgn_probe")) { $v->delete(); }
  View::create([
    "id" => "vgn_probe", "label" => "VGN Probe", "base_table" => "node_field_data",
    "display" => [
      "default" => ["display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,
        "display_options"=>["title"=>"VGN Probe","fields"=>[]]],
      "feed_1" => ["display_plugin"=>"feed","id"=>"feed_1","display_title"=>"Feed","position"=>1,
        "display_options"=>["path"=>"vgn-probe.xml",
          "style"=>["type"=>"google_news"],
          "row"=>["type"=>"google_news_fields","options"=>["loc_field"=>"view_node","news_title_field"=>"title","news_publication_date_field"=>"created"]],
          "defaults"=>["style"=>false,"row"=>false,"path"=>false]]],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vgn_probe feed display uses google_news style + google_news_fields row (loc_field=view_node)"
