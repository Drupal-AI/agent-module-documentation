#!/usr/bin/env bash
# Execution VERIFY: PASS when a published path_file_entity named "PF Task Doc" exists, references a
# file (fid), and a path alias /pf-task-doc points at its canonical /path-file/<id> route.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $store = \Drupal::entityTypeManager()->getStorage("path_file_entity");
  $pfs = $store->loadByProperties(["name" => "PF Task Doc"]);
  $pf = $pfs ? reset($pfs) : NULL;
  $has_file = $pf ? (bool) $pf->getFid() : FALSE;
  $published = $pf ? (bool) $pf->isPublished() : FALSE;
  $alias_ok = FALSE;
  if ($pf) {
    $aliases = \Drupal::entityTypeManager()->getStorage("path_alias")->loadByProperties([
      "alias" => "/pf-task-doc", "path" => "/path-file/" . $pf->id(),
    ]);
    $alias_ok = !empty($aliases);
  }
  $ok = $pf && $has_file && $published && $alias_ok;
  print ($ok ? "PASS" : "FAIL") . " entity=" . ($pf ? "yes" : "no") . " fid=" . var_export($has_file, TRUE) . " published=" . var_export($published, TRUE) . " alias=" . var_export($alias_ok, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
