#!/usr/bin/env bash
# Introspection SETUP: install a KNOWN quicktabs_instance `eval_intro_tabs` so an
# inspecting agent can read it back via drush. Known facts baked in here:
#   renderer   = accordion_tabs
#   tab count  = 3
#   tab titles = Shipping, Returns, Warranty
# Idempotent: deletes any prior eval_intro_tabs first. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $id = "eval_intro_tabs";
  $storage = \Drupal::entityTypeManager()->getStorage("quicktabs_instance");
  if ($qt = $storage->load($id)) { $qt->delete(); }
  $mk = function ($title, $weight) {
    return [
      "title" => $title,
      "weight" => $weight,
      "type" => "block_content",
      "content" => [
        "block_content" => [
          "options" => [
            "bid" => "system_powered_by_block",
            "block_title" => $title,
            "display_title" => TRUE,
          ],
        ],
      ],
    ];
  };
  $qt = $storage->create([
    "id" => $id,
    "label" => "Eval Intro Tabs",
    "renderer" => "accordion_tabs",
    "hide_empty_tabs" => FALSE,
    "remember_last_clicked_tab" => FALSE,
    "default_tab" => 0,
    "configuration_data" => [
      $mk("Shipping", 0),
      $mk("Returns", 1),
      $mk("Warranty", 2),
    ],
  ]);
  $qt->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: quicktabs_instance eval_intro_tabs installed (renderer accordion_tabs, 3 tabs: Shipping/Returns/Warranty)"
