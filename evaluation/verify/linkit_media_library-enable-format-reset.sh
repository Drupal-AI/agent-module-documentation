#!/usr/bin/env bash
# Execution RESET: create the Linkit profile lml_wire_profile (WITH an entity:media matcher) plus
# a CKEditor 5 text format lml_task_format on which the Linkit URL converter filter is DISABLED
# and the CKEditor 5 Linkit extension is off, so verify FAILS until the agent wires them up.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\linkit\Entity\Profile;
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  $p = Profile::load("lml_wire_profile");
  if (!$p) {
    $p = Profile::create(["id" => "lml_wire_profile", "label" => "LML Wire Profile"]);
    $p->save();
  }
  $hasMedia = FALSE;
  foreach ($p->getMatchers() as $m) { if ($m->getPluginId() === "entity:media") { $hasMedia = TRUE; } }
  if (!$hasMedia) {
    $matcher = \Drupal::service("plugin.manager.linkit.matcher")->createInstance("entity:media");
    $p->addMatcher($matcher->getConfiguration());
    $p->save();
  }
  $f = FilterFormat::load("lml_task_format");
  if (!$f) {
    $f = FilterFormat::create(["format" => "lml_task_format", "name" => "LML Task Format", "weight" => 56, "filters" => []]);
  }
  $f->setFilterConfig("linkit", ["status" => FALSE, "weight" => 0, "settings" => []]);
  $f->save();
  $e = Editor::load("lml_task_format");
  if (!$e) {
    $e = Editor::create([
      "format" => "lml_task_format",
      "editor" => "ckeditor5",
      "settings" => ["toolbar" => ["items" => ["bold", "italic", "link"]], "plugins" => []],
      "image_upload" => ["status" => FALSE],
    ]);
  }
  $settings = $e->getSettings();
  unset($settings["plugins"]["linkit_extension"]);
  $e->setSettings($settings);
  $e->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: lml_task_format has linkit filter OFF and no linkit_extension settings"
