#!/usr/bin/env bash
# Execution VERIFY: PASS when a site settings group ss_task_group exists, a site settings TYPE
# ss_task_strapline exists in that group with multiple = FALSE, it has a field
# field_ss_task_text, and one published site_setting_entity of that type stores the value
# "We build better websites". Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\site_settings\Entity\SiteSettingEntityType;
  use Drupal\site_settings\Entity\SiteSettingGroupEntityType;
  use Drupal\field\Entity\FieldConfig;
  $group = SiteSettingGroupEntityType::load("ss_task_group");
  $type = SiteSettingEntityType::load("ss_task_strapline");
  $field = FieldConfig::loadByName("site_setting_entity", "ss_task_strapline", "field_ss_task_text");
  $entities = \Drupal::entityTypeManager()->getStorage("site_setting_entity")->loadByProperties(["type" => "ss_task_strapline"]);
  $value = NULL;
  if ($entities) {
    $e = reset($entities);
    $value = $e->hasField("field_ss_task_text") ? $e->get("field_ss_task_text")->value : NULL;
  }
  $inGroup = $type ? ((string) $type->get("group") === "ss_task_group") : FALSE;
  $ok = (bool) $group && (bool) $type && $inGroup && (bool) $field
    && (trim((string) $value) === "We build better websites");
  print ($ok ? "PASS" : "FAIL")
    . " group=" . var_export((bool) $group, TRUE)
    . " type=" . var_export((bool) $type, TRUE)
    . " type_group=" . var_export($type ? $type->get("group") : NULL, TRUE)
    . " field=" . var_export((bool) $field, TRUE)
    . " value=" . var_export($value, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
