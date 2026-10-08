#!/usr/bin/env bash
# Execution VERIFY for "make a thumbnail style usable for a remote image".
# PASS when: image style rsw_task_thumb exists with an image_scale effect of width 240; a
# permanent managed file named rsw_task_thumb_source.png exists whose uri is the remote
# http:// URL; and the style's derivative URI for that file is routed through
# remote_stream_wrapper's ImageStyle override, i.e. it starts with
# public://styles/rsw_task_thumb/http/. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  $style = ImageStyle::load("rsw_task_thumb");
  $scaleOk = FALSE;
  if ($style) {
    foreach ($style->getEffects() as $effect) {
      $cfg = $effect->getConfiguration();
      if (($cfg["id"] ?? NULL) === "image_scale" && (int) ($cfg["data"]["width"] ?? 0) === 240) {
        $scaleOk = TRUE;
      }
    }
  }
  $files = \Drupal::entityTypeManager()->getStorage("file")
    ->loadByProperties(["filename" => "rsw_task_thumb_source.png"]);
  $file = $files ? reset($files) : NULL;
  $uri = $file ? $file->getFileUri() : "";
  $fileOk = $file && $uri === "http://web/core/misc/druplicon.png" && (int) $file->get("status")->value === 1;
  $derivative = ($style && $fileOk) ? $style->buildUri($uri) : "";
  $derivOk = str_starts_with($derivative, "public://styles/rsw_task_thumb/http/");
  $ok = $style && $scaleOk && $fileOk && $derivOk;
  print ($ok ? "PASS" : "FAIL")
    . " style=" . ($style ? "yes" : "missing")
    . " scale240=" . var_export($scaleOk, TRUE)
    . " file_uri=" . ($uri ?: "none")
    . " derivative=" . ($derivative ?: "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
