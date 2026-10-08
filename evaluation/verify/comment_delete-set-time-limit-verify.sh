#!/usr/bin/env bash
# Execution VERIFY: PASS when node.field_blog_comments comment_delete has time_limit===true and
# timer==600. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $f = FieldConfig::loadByName("node","blog_post","field_blog_comments");
  $tl = $f ? $f->getThirdPartySetting("comment_delete","time_limit") : NULL;
  $tm = $f ? $f->getThirdPartySetting("comment_delete","timer") : NULL;
  $ok = ($tl === TRUE && (int) $tm === 600);
  print ($ok ? "PASS" : "FAIL") . " time_limit=" . var_export($tl,TRUE) . " timer=" . var_export($tm,TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
