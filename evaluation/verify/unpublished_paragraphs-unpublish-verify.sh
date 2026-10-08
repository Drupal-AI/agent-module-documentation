#!/usr/bin/env bash
# Execution VERIFY: PASS when the paragraph whose field_up_body is 'Toggle target block' is
# unpublished (status 0). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
$pst=\Drupal::entityTypeManager()->getStorage("paragraph");
$ps=$pst->loadByProperties(["field_up_body"=>"Toggle target block"]);
if(!$ps){print "FAIL missing\n"; return;}
$p=reset($ps);
print ($p->isPublished() ? "FAIL" : "PASS") . " status=" . var_export($p->isPublished(), TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
