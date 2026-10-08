#!/usr/bin/env bash
# Execution VERIFY: PASS when mel_task's Lottie player display formatter has hover === TRUE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\media\Entity\MediaType;
  $t = MediaType::load("mel_task");
  $hover = NULL; $type = "none";
  if ($t) {
    $sf = $t->getSource()->getConfiguration()["source_field"] ?? NULL;
    $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("media.mel_task.default");
    $c = ($vd && $sf) ? $vd->getComponent($sf) : NULL;
    $type = $c["type"] ?? "none";
    $hover = $c["settings"]["hover"] ?? NULL;
  }
  $ok = ($type === "file_lottie_player" && $hover == TRUE);
  print ($ok ? "PASS" : "FAIL") . " fmt=" . $type . " hover=" . var_export($hover, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
