#!/usr/bin/env bash
# Introspection SETUP: create a text format ace_editor_m1 that uses the Ace editor plugin
# with a known theme (monokai) and syntax (php), so an inspecting agent can read back which
# format uses the Ace code editor and its configured theme. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("ace_editor_m1")) {
    FilterFormat::create(["format" => "ace_editor_m1", "name" => "Ace Editor M1"])->save();
  }
  if ($e = Editor::load("ace_editor_m1")) { $e->delete(); }
  Editor::create([
    "format" => "ace_editor_m1", "editor" => "ace_editor",
    "settings" => ["fieldset" => [
      "theme" => "monokai", "syntax" => "php", "height" => "300px", "width" => "100%",
      "font_size" => "12pt", "line_numbers" => TRUE, "print_margins" => TRUE,
      "show_invisibles" => FALSE, "use_wrap_mode" => TRUE, "auto_complete" => TRUE,
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: text format ace_editor_m1 uses editor=ace_editor with fieldset.theme=monokai, syntax=php"
