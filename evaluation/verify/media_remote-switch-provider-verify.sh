#!/usr/bin/env bash
# Execution VERIFY for "switch mr_switch from Loom to Google Drive embeds at 1024x768".
# PASS when core.entity_view_display.media.mr_switch.default renders field_mr_switch with the
# `media_remote_google` formatter, settings.formatter_class is MediaRemoteGoogleFormatter, and
# width/height are 1024/768. Also asserts the change really drives validation: a published
# Google Docs URL must validate cleanly while the old Loom URL must now be rejected.
# No media entity is saved. Caches are reset before reading. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  \Drupal::configFactory()->reset();
  $d = \Drupal\Core\Entity\Entity\EntityViewDisplay::load("media.mr_switch.default");
  $c = $d ? $d->getComponent("field_mr_switch") : NULL;
  $type = $c["type"] ?? "none";
  $class = $c["settings"]["formatter_class"] ?? "";
  $w = $c["settings"]["width"] ?? NULL;
  $h = $c["settings"]["height"] ?? NULL;
  $google = "Drupal\\media_remote\\Plugin\\Field\\FieldFormatter\\MediaRemoteGoogleFormatter";
  $good = $bad = -1;
  if ($type === "media_remote_google") {
    $m1 = \Drupal\media\Entity\Media::create(["bundle" => "mr_switch", "name" => "probe ok", "field_mr_switch" => "https://docs.google.com/document/d/e/2PACX-1vAbCdEf/pub"]);
    $m2 = \Drupal\media\Entity\Media::create(["bundle" => "mr_switch", "name" => "probe bad", "field_mr_switch" => "https://www.loom.com/share/91ad056cbe274b3f82add5e48beba123"]);
    $good = $m1->validate()->count();
    $bad = $m2->validate()->count();
  }
  $ok = ($type === "media_remote_google") && (ltrim($class, "\\") === $google)
    && ((string) $w === "1024") && ((string) $h === "768") && ($good === 0) && ($bad > 0);
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $type . " formatter_class=" . ($class ?: "none")
    . " width=" . var_export($w, TRUE) . " height=" . var_export($h, TRUE)
    . " google_url_violations=" . $good . " loom_url_violations=" . $bad . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
