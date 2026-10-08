#!/usr/bin/env bash
# Execution VERIFY: the former job of the obsolete manage_display_fix_title submodule must be
# achieved through the parent module WITHOUT installing the submodule.
# PASS when (a) core.entity_view_display.node.article.mdft_task has a `title` component of type
# `title` with settings.tag === "h1" and a falsey link_to_entity, and (b) the module
# manage_display_fix_title is still NOT installed. Caches are reset before reading.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  \Drupal::configFactory()->reset("core.entity_view_display.node.article.mdft_task");
  $s = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  $s->resetCache(["node.article.mdft_task"]);
  $d = $s->load("node.article.mdft_task");
  $c = $d ? $d->getComponent("title") : NULL;
  $type = $c["type"] ?? "none";
  $tag = $c["settings"]["tag"] ?? NULL;
  $link = $c["settings"]["link_to_entity"] ?? NULL;
  $sub = \Drupal::moduleHandler()->moduleExists("manage_display_fix_title");
  $ok = ($type === "title") && ($tag === "h1") && empty($link) && !$sub;
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $type . " tag=" . var_export($tag, TRUE)
    . " link_to_entity=" . var_export($link, TRUE) . " fix_title_installed=" . var_export($sub, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
