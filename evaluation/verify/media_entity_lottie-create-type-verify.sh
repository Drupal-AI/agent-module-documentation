#!/usr/bin/env bash
# Execution VERIFY: PASS when a media type 'mel_build' exists using the lottie_file source and its
# source field is a file field limited to the json extension. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\media\Entity\MediaType;
  $t = MediaType::load("mel_build");
  $ok = FALSE; $src = "none"; $ext = "none";
  if ($t) {
    $src = $t->getSource()->getPluginId();
    $sf = $t->getSource()->getConfiguration()["source_field"] ?? NULL;
    if ($src === "lottie_file" && $sf) {
      $fc = \Drupal\field\Entity\FieldConfig::loadByName("media","mel_build",$sf);
      $ext = $fc ? (string) $fc->getSetting("file_extensions") : "none";
      $ok = ($fc && strpos($ext, "json") !== FALSE);
    }
  }
  print ($ok ? "PASS" : "FAIL") . " source=" . $src . " ext=" . $ext . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
