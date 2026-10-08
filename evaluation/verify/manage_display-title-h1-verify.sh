#!/usr/bin/env bash
# Execution VERIFY for "render the Article title as an unlinked H1 in the md_task view mode".
# PASS when core.entity_view_display.node.article.md_task has a `title` component using the
# manage_display `title` formatter with settings.tag === "h1" and settings.link_to_entity falsey.
# Caches are reset first so a stale config cache cannot report an out-of-date value.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  \Drupal::configFactory()->reset("core.entity_view_display.node.article.md_task");
  $s = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  $s->resetCache(["node.article.md_task"]);
  $d = $s->load("node.article.md_task");
  $c = $d ? $d->getComponent("title") : NULL;
  $type = $c["type"] ?? "none";
  $tag = $c["settings"]["tag"] ?? NULL;
  $link = $c["settings"]["link_to_entity"] ?? NULL;
  $ok = ($type === "title") && ($tag === "h1") && empty($link);
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $type . " tag=" . var_export($tag, TRUE) . " link_to_entity=" . var_export($link, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
