#!/usr/bin/env bash
# Execution VERIFY: PASS when lp_fontawesome_attach is enabled AND its hook_page_attachments
# attaches the 'lp_fontawesome/fontawesome-svg' library. Invokes only that module's hook.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $mh = \Drupal::moduleHandler();
  $ok = FALSE; $enabled = $mh->moduleExists("lp_fontawesome_attach");
  if ($enabled) {
    $a = [];
    $mh->invoke("lp_fontawesome_attach", "page_attachments", [&$a]);
    $libs = $a["#attached"]["library"] ?? [];
    $ok = in_array("lp_fontawesome/fontawesome-svg", $libs, TRUE);
  }
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($enabled, TRUE) . " attached=" . ($ok ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
