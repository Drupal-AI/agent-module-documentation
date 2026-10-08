#!/usr/bin/env bash
# Execution VERIFY: PASS when a media_thumbnail plugin with id mt_probe_thumbnail is
# discoverable, declares the MIME type application/x-mt-probe and its class implements
# MediaThumbnailInterface. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
out=$(drush php:eval '
  $m = \Drupal::service("plugin.manager.media_thumbnail");
  $defs = $m->getDefinitions();
  $d = $defs["mt_probe_thumbnail"] ?? NULL;
  if (!$d) { print "FAIL plugin-missing found=" . implode(",", array_keys($defs)) . "\n"; return; }
  $mime = (array) ($d["mime"] ?? []);
  $class = $d["class"] ?? "";
  $ok = in_array("application/x-mt-probe", $mime, TRUE)
    && $class !== ""
    && is_subclass_of($class, "Drupal\\media_thumbnails\\Plugin\\MediaThumbnailInterface");
  print ($ok ? "PASS" : "FAIL") . " id=mt_probe_thumbnail mime=" . implode("|", $mime) . " class=" . $class . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
