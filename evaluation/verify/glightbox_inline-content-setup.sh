#!/usr/bin/env bash
# Introspection SETUP: create an Article whose body uses a glightbox_inline trigger link, so an agent
# can inspect the content and identify the class/target. Idempotent (removes prior copy first).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"glb inline demo"]) as $n) { $n->delete(); }
  Node::create([
    "type"=>"article","title"=>"glb inline demo","status"=>1,
    "body"=>["value"=>"<p><a class=\"glightbox-inline\" href=\"#glb-target\">Open panel</a></p><div id=\"glb-target\">Hidden content</div>","format"=>"full_html"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: Article 'glb inline demo' body has a glightbox-inline link to #glb-target"
