#!/usr/bin/env bash
# Execution RESET: create footnotes_eval with the Footnotes filter PRESENT but DISABLED
# (status=false), so verify FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("footnotes_eval")) { $f->delete(); }
  FilterFormat::create([
    "format"=>"footnotes_eval","name"=>"Footnotes Eval",
    "filters"=>["filter_footnotes"=>["id"=>"filter_footnotes","provider"=>"footnotes","status"=>FALSE,"weight"=>0,
      "settings"=>["footnotes_collapse"=>FALSE,"footnotes_css"=>TRUE,"footnotes_dialog"=>FALSE,
        "footnotes_dialog_prevent_bubbling"=>FALSE,"footnotes_footer_disable"=>FALSE,
        "footnotes_preview_show_text"=>TRUE,"footnotes_preview_character"=>""]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: footnotes_eval created with filter_footnotes DISABLED"
