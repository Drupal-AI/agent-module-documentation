#!/usr/bin/env bash
# Execution VERIFY for "build a Remote Media type mr_task that embeds Loom videos".
# PASS when ALL of:
#   - media type mr_task exists and its source plugin is `media_remote`
#   - source_configuration.source_field names a real `string` field on the bundle
#   - core.entity_view_display.media.mr_task.default renders that field with the
#     `media_remote_loom` formatter whose settings.formatter_class is the Loom formatter class
#   - a Loom share URL validates cleanly through the media_remote constraint while a
#     non-Loom URL is rejected (proves the wiring actually drives validation)
# No media entity is saved (saving media fatals on this shared site via an unrelated contrib
# module). Caches are reset before reading. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  \Drupal::configFactory()->reset();
  $t = \Drupal\media\Entity\MediaType::load("mr_task");
  if (!$t) { print "FAIL media type mr_task missing\n"; return; }
  $src = $t->getSource();
  $sid = $src->getPluginId();
  $sf = $src->getConfiguration()["source_field"] ?? "";
  $fc = $sf ? \Drupal\field\Entity\FieldConfig::loadByName("media", "mr_task", $sf) : NULL;
  $ftype = $fc ? $fc->getType() : "none";
  $d = \Drupal\Core\Entity\Entity\EntityViewDisplay::load("media.mr_task.default");
  $c = $d ? $d->getComponent($sf) : NULL;
  $type = $c["type"] ?? "none";
  $class = $c["settings"]["formatter_class"] ?? "";
  $loom = "Drupal\\media_remote\\Plugin\\Field\\FieldFormatter\\MediaRemoteLoomFormatter";
  $good = $bad = -1;
  if ($sf && $type === "media_remote_loom") {
    $m1 = \Drupal\media\Entity\Media::create(["bundle" => "mr_task", "name" => "probe ok", $sf => "https://www.loom.com/share/91ad056cbe274b3f82add5e48beba123"]);
    $m2 = \Drupal\media\Entity\Media::create(["bundle" => "mr_task", "name" => "probe bad", $sf => "https://example.com/not-loom"]);
    $good = $m1->validate()->count();
    $bad = $m2->validate()->count();
  }
  $ok = ($sid === "media_remote") && ($ftype === "string") && ($type === "media_remote_loom")
    && (ltrim($class, "\\") === $loom) && ($good === 0) && ($bad > 0);
  print ($ok ? "PASS" : "FAIL") . " source=" . $sid . " source_field=" . ($sf ?: "none")
    . " field_type=" . $ftype . " formatter=" . $type . " formatter_class=" . ($class ?: "none")
    . " valid_url_violations=" . $good . " invalid_url_violations=" . $bad . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
