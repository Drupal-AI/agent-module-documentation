#!/usr/bin/env bash
# Execution RESET/CLEANUP: restore shipped defaults so verify FAILS on empty state. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$c = \Drupal::configFactory()->getEditable("improved_multi_select.settings");
  $c->set("isall", FALSE)->set("url", "")->set("selectors", "")
    ->set("placeholder_text", "")->set("filtertype", "partial")
    ->set("orderable", FALSE)->set("groupresetfilter", FALSE)->set("js_regex", FALSE)
    ->set("remove_required_attr", FALSE)
    ->set("buttontext_add", ">")->set("buttontext_addall", "\xc2\xbb")
    ->set("buttontext_del", "<")->set("buttontext_delall", "\xc2\xab")
    ->set("buttontext_moveup", "Move up")->set("buttontext_movedown", "Move down")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: improved_multi_select.settings restored to defaults (orderable=false, buttontext_add='>')"
