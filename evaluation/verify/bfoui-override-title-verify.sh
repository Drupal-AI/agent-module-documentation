#!/usr/bin/env bash
# Execution VERIFY: PASS when core.base_field_override.node.article.title exists with label
# 'Article Headline'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\Core\Field\Entity\BaseFieldOverride;
  $o = BaseFieldOverride::load("node.article.title");
  $label = $o ? $o->getLabel() : NULL;
  $ok = ($label === "Article Headline");
  print ($ok ? "PASS" : "FAIL") . " label=" . var_export($label, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
