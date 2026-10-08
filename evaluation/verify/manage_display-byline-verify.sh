#!/usr/bin/env bash
# Execution VERIFY for "show a Submitted by ... on ... byline with a user picture in md_author".
# PASS when core.entity_view_display.node.article.md_author has the owner field `uid` using the
# manage_display `submitted` formatter with settings.user_picture === "compact", AND a visible
# `created` component (so hook_entity_view_alter() has a date to fold into the sentence).
# Caches are reset first so a stale config cache cannot report an out-of-date value.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  \Drupal::configFactory()->reset("core.entity_view_display.node.article.md_author");
  $s = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  $s->resetCache(["node.article.md_author"]);
  $d = $s->load("node.article.md_author");
  $uid = $d ? $d->getComponent("uid") : NULL;
  $created = $d ? $d->getComponent("created") : NULL;
  $type = $uid["type"] ?? "none";
  $pic = $uid["settings"]["user_picture"] ?? NULL;
  $ok = ($type === "submitted") && ($pic === "compact") && !empty($created);
  print ($ok ? "PASS" : "FAIL") . " uid_formatter=" . $type . " user_picture=" . var_export($pic, TRUE)
    . " created=" . ($created ? ($created["type"] ?? "set") : "missing") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
