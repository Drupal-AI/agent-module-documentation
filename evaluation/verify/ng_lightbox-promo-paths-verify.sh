#!/usr/bin/env bash
# Execution VERIFY: PASS when ng_lightbox.settings lightboxes /contact and /about/* , uses a
# 1000px dialog with class promo-lightbox, and no longer skips admin paths — and when the live
# ng_lightbox service really reports /contact as a lightboxed path.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("ng_lightbox.settings");
  $patterns = (string) $c->get("patterns");
  $lines = array_values(array_filter(array_map("trim", preg_split("/\r?\n/", $patterns))));
  $has_contact = in_array("/contact", $lines, TRUE);
  $has_about = in_array("/about/*", $lines, TRUE);
  $matched = \Drupal::service("ng_lightbox")->isNgLightboxEnabledPath(\Drupal\Core\Url::fromUserInput("/contact"));
  $ok = $has_contact && $has_about
    && (int) $c->get("default_width") === 1000
    && $c->get("lightbox_class") === "promo-lightbox"
    && $c->get("skip_admin_paths") == FALSE
    && $matched === TRUE;
  print ($ok ? "PASS" : "FAIL")
    . " patterns=" . implode("|", $lines)
    . " width=" . var_export($c->get("default_width"), TRUE)
    . " class=" . var_export($c->get("lightbox_class"), TRUE)
    . " skip_admin=" . var_export($c->get("skip_admin_paths"), TRUE)
    . " service_matches_contact=" . var_export($matched, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
