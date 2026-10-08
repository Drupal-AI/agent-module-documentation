#!/usr/bin/env bash
# Execution RESET for the "icon-only GitHub brand link" task. Ensures a custom menu link
# titled "FA Eval Social" exists in the `main` menu with NO Font Awesome icon set, so the
# case starts from empty state (verify must FAIL here). Creates the link if missing, strips
# any fa_icon* options if present. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ids = \Drupal::entityTypeManager()->getStorage("menu_link_content")
    ->getQuery()->accessCheck(FALSE)->condition("title", "FA Eval Social")->execute();
  $list = \Drupal\menu_link_content\Entity\MenuLinkContent::loadMultiple($ids);
  if (!$list) {
    $ml = \Drupal\menu_link_content\Entity\MenuLinkContent::create([
      "title" => "FA Eval Social",
      "menu_name" => "main",
      "link" => ["uri" => "https://github.com", "options" => []],
    ]);
    $ml->save();
  }
  else {
    foreach ($list as $ml) {
      $opts = $ml->link->first()->options ?: [];
      foreach (["fa_icon","fa_icon_prefix","fa_icon_tag","fa_icon_appearance","already_processed"] as $k) { unset($opts[$k]); }
      $ml->link->first()->options = $opts;
      $ml->save();
    }
  }
  print "reset: \"FA Eval Social\" present in main menu with no icon\n";
' 2>/dev/null | grep -a '^reset:'
drush cr >/dev/null 2>&1
