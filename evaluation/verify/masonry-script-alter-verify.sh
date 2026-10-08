#!/usr/bin/env bash
# Execution VERIFY: PASS when the masonry_eval_alter module is enabled AND its
# hook_masonry_script_alter() implementation adds extra_options.horizontalOrder = TRUE for a
# display whose masonry_ids include 'masonry_eval_target' (checked by actually calling
# MasonryService::applyMasonryDisplay()). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  if (!\Drupal::moduleHandler()->moduleExists("masonry_eval_alter")) {
    print "FAIL module masonry_eval_alter is not enabled\n"; return;
  }
  $build = [];
  \Drupal::service("masonry.service")->applyMasonryDisplay(
    $build, ".masonry-alter-probe", ".masonry-alter-item", [], ["masonry_eval_target"]
  );
  $s = $build["#attached"]["drupalSettings"]["masonry"][".masonry-alter-probe"] ?? NULL;
  $val = $s["extra_options"]["horizontalOrder"] ?? NULL;
  // And confirm it does NOT fire for an unrelated id.
  $other = [];
  \Drupal::service("masonry.service")->applyMasonryDisplay(
    $other, ".masonry-alter-other", ".masonry-alter-item", [], ["masonry_default"]
  );
  $otherVal = $other["#attached"]["drupalSettings"]["masonry"][".masonry-alter-other"]["extra_options"]["horizontalOrder"] ?? NULL;
  $ok = ($val === TRUE) && ($otherVal === NULL);
  print ($ok ? "PASS" : "FAIL")
    . " targeted=" . var_export($val, TRUE)
    . " untargeted=" . var_export($otherVal, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
