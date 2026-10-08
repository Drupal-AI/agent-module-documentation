#!/usr/bin/env bash
# Live-state verification for the "sitewide banner on every page EXCEPT the front page" task.
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments.
# Checks block `bep_sitewide_banner`'s core request_path visibility:
#   blk — the block exists and has a request_path visibility condition
#   inc — an include line covers the whole site (a non-'!' line "/*")
#   exc — an exclude line targets the front page ("!<front>")
#   neg — negate is FALSE ("show for the listed pages")
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $blk = $inc = $exc = $negok = FALSE; $detail = "";
  if ($b = \Drupal::entityTypeManager()->getStorage("block")->load("bep_sitewide_banner")) {
    $v = $b->getVisibility();
    if (!empty($v["request_path"])) {
      $blk = TRUE;
      $rp = $v["request_path"];
      $negok = empty($rp["negate"]);
      $lines = preg_split("/\r\n|\r|\n/", strtolower(trim($rp["pages"] ?? "")));
      foreach ($lines as $ln) {
        $ln = trim($ln);
        if ($ln === "") { continue; }
        if ($ln[0] === "!") {
          $p = trim(substr($ln, 1));
          if ($p === "<front>") { $exc = TRUE; }
        }
        else {
          if ($ln === "/*") { $inc = TRUE; }
        }
      }
      $detail = "pages=" . json_encode($rp["pages"] ?? null) . " negate=" . var_export($rp["negate"] ?? null, true);
    }
  }
  $ok = $blk && $inc && $exc && $negok;
  print ($ok ? "PASS" : "FAIL") . " blk=".($blk?1:0)." inc=".($inc?1:0)." exc=".($exc?1:0)." neg=".($negok?1:0)." ".$detail."\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
