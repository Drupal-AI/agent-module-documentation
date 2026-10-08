#!/usr/bin/env bash
# Execution RESET: ensure text format ace_editor_h1 exists WITHOUT any text editor attached,
# so verify FAILS until the agent assigns the Ace editor. Deletes any editor.editor.ace_editor_h1.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("ace_editor_h1")) { $e->delete(); }
  if (!FilterFormat::load("ace_editor_h1")) {
    FilterFormat::create(["format" => "ace_editor_h1", "name" => "Ace Editor H1"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: format ace_editor_h1 present, no editor attached"
