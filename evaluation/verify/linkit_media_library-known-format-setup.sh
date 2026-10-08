#!/usr/bin/env bash
# Introspection SETUP: create a Linkit profile lml_fmt_profile (with an entity:media matcher) and
# a text format lml_eval_format whose CKEditor 5 Linkit extension points at that profile and whose
# 'Linkit URL converter' filter is enabled - the exact combination linkit_media_library requires.
# The agent must inspect the live editor/filter config to name the profile. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\linkit\Entity\Profile;
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  $p = Profile::load("lml_fmt_profile");
  if (!$p) {
    $p = Profile::create(["id" => "lml_fmt_profile", "label" => "LML Format Profile"]);
    $p->save();
  }
  $hasMedia = FALSE;
  foreach ($p->getMatchers() as $m) { if ($m->getPluginId() === "entity:media") { $hasMedia = TRUE; } }
  if (!$hasMedia) {
    $matcher = \Drupal::service("plugin.manager.linkit.matcher")->createInstance("entity:media");
    $p->addMatcher($matcher->getConfiguration());
    $p->save();
  }
  $f = FilterFormat::load("lml_eval_format");
  if (!$f) {
    $f = FilterFormat::create(["format" => "lml_eval_format", "name" => "LML Eval Format", "weight" => 55, "filters" => []]);
  }
  $f->setFilterConfig("linkit", ["status" => TRUE, "weight" => 0, "settings" => []]);
  $f->save();
  $e = Editor::load("lml_eval_format");
  if (!$e) {
    $e = Editor::create([
      "format" => "lml_eval_format",
      "editor" => "ckeditor5",
      "settings" => ["toolbar" => ["items" => ["bold", "italic", "link"]], "plugins" => []],
      "image_upload" => ["status" => FALSE],
    ]);
  }
  $settings = $e->getSettings();
  $settings["plugins"]["linkit_extension"] = ["linkit_enabled" => TRUE, "linkit_profile" => "lml_fmt_profile"];
  $e->setSettings($settings);
  $e->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: text format lml_eval_format -> linkit filter on, linkit_extension profile lml_fmt_profile"
