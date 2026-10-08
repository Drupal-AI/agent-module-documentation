#!/usr/bin/env bash
# Introspection SETUP: create a dir_listing node "FB Known Listing" pointing at a known
# folder URI (public://fb_eval_docs) so an inspecting agent can read the folder back from
# the filebrowser_nodes table. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  use Drupal\filebrowser\Filebrowser;
  $ids = \Drupal::entityTypeManager()->getStorage("node")->getQuery()
    ->accessCheck(FALSE)->condition("type","dir_listing")->condition("title","FB Known Listing")->execute();
  if (!$ids) {
    $n = Node::create(["type"=>"dir_listing","title"=>"FB Known Listing"]);
    $n->filebrowser = new Filebrowser([
      "folder_path"=>"public://fb_eval_docs",
      "rights"=>["explore_subdirs"=>1,"download_archive"=>0,"create_folders"=>0,"download_manager"=>"private","force_download"=>0,"forbidden_files"=>"","whitelist"=>""],
      "uploads"=>["enabled"=>1,"allow_overwrite"=>0,"accepted"=>"pdf txt"],
      "presentation"=>["overwrite_breadcrumb"=>1,"default_view"=>"list-view","encoding"=>"UTF-8","hide_extension"=>0,"visible_columns"=>["name"=>"name"],"default_sort"=>"name","default_sort_order"=>"asc","grid_settings"=>["alignment"=>"","columns"=>"","image_style"=>"","auto_width"=>"","grid_height"=>"","grid_width"=>"","grid_hide_title"=>""]],
      "adhocsetting"=>["external_host"=>""],
    ]);
    $n->save();
  }
' >/dev/null 2>&1
echo "setup: dir_listing 'FB Known Listing' -> folder_path public://fb_eval_docs"
