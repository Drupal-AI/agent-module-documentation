#!/usr/bin/env bash
# Introspection SETUP: create a daterange field field_dad_probe on Article with the
# date_all_day widget, and two Article nodes: "DAD All Day Probe" whose range is
# 00:00:00 -> 23:59:59 (which date_all_day treats as ALL DAY) and "DAD Timed Probe" whose
# range has real times (not all day). The agent must inspect the stored values to say which
# node counts as all-day. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;
  if (!FieldStorageConfig::loadByName("node", "field_dad_probe")) {
    FieldStorageConfig::create([
      "field_name" => "field_dad_probe", "entity_type" => "node",
      "type" => "daterange", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_dad_probe")) {
    FieldConfig::create([
      "field_name" => "field_dad_probe", "entity_type" => "node",
      "bundle" => "article", "label" => "DAD Probe Dates",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_dad_probe", [
    "type" => "daterange_all_day", "weight" => 71, "region" => "content",
    "settings" => [], "third_party_settings" => [],
  ])->save();
  // Store in UTC; the site default timezone decides all-day-ness, so compute the offset.
  $tz = new \DateTimeZone(date_default_timezone_get());
  $mk = function (string $local) use ($tz) {
    $d = new \DateTime($local, $tz);
    $d->setTimezone(new \DateTimeZone("UTC"));
    return $d->format("Y-m-d\TH:i:s");
  };
  foreach ([
    ["DAD All Day Probe", $mk("2026-09-01 00:00:00"), $mk("2026-09-01 23:59:59")],
    ["DAD Timed Probe",   $mk("2026-09-02 09:30:00"), $mk("2026-09-02 17:00:00")],
  ] as [$title, $start, $end]) {
    $existing = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => $title]);
    foreach ($existing as $n) { $n->delete(); }
    Node::create([
      "type" => "article", "title" => $title, "status" => 1,
      "field_dad_probe" => ["value" => $start, "end_value" => $end],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: nodes 'DAD All Day Probe' (00:00:00-23:59:59 local) and 'DAD Timed Probe' created with field_dad_probe"
