#!/usr/bin/env bash
# Execution RESET: create/reset a base view vba_field_task with a default display and NO block field,
# so verify FAILS until the agent adds one. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
use Drupal\views\Entity\View;
if ($v = View::load("vba_field_task")) $v->delete();
View::create(["id"=>"vba_field_task","label"=>"VBA Field Task","base_table"=>"node_field_data","base_field"=>"nid",
  "display"=>["default"=>["display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,
    "display_options"=>["title"=>"VBA Field Task"]]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vba_field_task present with no Block field"
