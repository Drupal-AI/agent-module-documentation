#!/usr/bin/env bash
# Execution VERIFY: PASS when webform srw_cfg has a simple_recaptcha handler configured for
# reCAPTCHA v3 with score 70. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\webform\Entity\Webform;
  $w = Webform::load("srw_cfg");
  $ok = FALSE; $type = "none"; $score = "none";
  if ($w) {
    foreach ($w->getHandlers() as $h) {
      if ($h->getPluginId() === "simple_recaptcha") {
        $cfg = $h->getConfiguration();
        $type = $cfg["settings"]["recaptcha_type"] ?? "none";
        $score = (string) ($cfg["settings"]["v3_score"] ?? "none");
        if ($type === "v3" && (int) $score === 70) { $ok = TRUE; }
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " type=$type score=$score\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
