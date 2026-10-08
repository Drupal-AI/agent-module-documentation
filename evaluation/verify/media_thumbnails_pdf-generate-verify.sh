#!/usr/bin/env bash
# Execution VERIFY: PASS when a media entity named mtpdf_eval exists and its thumbnail is a
# generated .jpg (i.e. the media_thumbnail_pdf plugin ran), not a generic icon. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\file\Entity\File;
  $ms = \Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "mtpdf_eval"]);
  $m = $ms ? reset($ms) : NULL;
  $uri = "";
  if ($m) {
    $tid = $m->get("thumbnail")->target_id;
    if ($tid && ($t = File::load($tid))) { $uri = $t->getFileUri(); }
  }
  $ok = $m && (substr($uri, -4) === ".jpg");
  print ($ok ? "PASS" : "FAIL") . " media=" . ($m ? "yes" : "no") . " thumb=" . ($uri ?: "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
