#!/usr/bin/env bash
# Execution VERIFY: include the agent's snippet and check the render array it returns really was
# produced by MasonryService::applyMasonryDisplay() - masonry/masonry.layout attached and the
# expected drupalSettings.masonry payload for '.masonry-eval-grid'.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
if [ ! -f web/sites/default/files/masonry_eval/apply.php ]; then
  echo "FAIL missing web/sites/default/files/masonry_eval/apply.php"
  exit 1
fi
out=$(drush php:eval '
  // drush runs PHP with the Drupal root as cwd, so resolve from DRUPAL_ROOT.
  $file = DRUPAL_ROOT . "/sites/default/files/masonry_eval/apply.php";
  $build = include $file;
  if (!is_array($build)) { print "FAIL snippet did not return an array\n"; return; }
  $libs = $build["#attached"]["library"] ?? [];
  $s = $build["#attached"]["drupalSettings"]["masonry"][".masonry-eval-grid"] ?? NULL;
  $ok = in_array("masonry/masonry.layout", $libs, TRUE)
    && is_array($s)
    && ($s["item_selector"] ?? NULL) === ".masonry-eval-item"
    && (string) ($s["column_width"] ?? "") === "250"
    && ($s["column_width_units"] ?? NULL) === "px"
    && (string) ($s["gutter_width"] ?? "") === "10"
    && ($s["gutter_width_units"] ?? NULL) === "px"
    && in_array("masonry_eval_case", $s["masonry_ids"] ?? [], TRUE);
  print ($ok ? "PASS" : "FAIL")
    . " libs=" . implode(",", $libs)
    . " settings=" . json_encode($s) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
