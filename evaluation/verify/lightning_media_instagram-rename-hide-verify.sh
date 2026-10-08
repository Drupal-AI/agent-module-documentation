#!/usr/bin/env bash
# Execution VERIFY: PASS when the Instagram media type is labelled 'Instagram Post' and the
# default value of field_media_in_library on that bundle is FALSE. exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t = \Drupal\media\Entity\MediaType::load("instagram");
  $f = \Drupal\field\Entity\FieldConfig::loadByName("media", "instagram", "field_media_in_library");
  $default = NULL;
  if ($f) { $v = $f->getDefaultValueLiteral(); $default = $v ? $v[0]["value"] : NULL; }
  $checks = [
    "label" => $t && (string) $t->label() === "Instagram Post",
    "default_false" => ($default !== NULL && !$default),
  ];
  $bad = array_keys(array_filter($checks, fn ($v) => !$v));
  print ($bad ? "FAIL wrong=" . implode(",", $bad) : "PASS")
    . " label=" . var_export($t ? (string) $t->label() : NULL, TRUE)
    . " default=" . var_export($default, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
