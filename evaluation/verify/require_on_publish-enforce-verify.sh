#!/usr/bin/env bash
# Execution VERIFY (behavioral): PASS only when the require_on_publish constraint actually enforces
# field_rop_enf on publish. Builds (without saving) a PUBLISHED Article with field_rop_enf empty and
# validates it -> must produce a violation on field_rop_enf; and an UNPUBLISHED one -> no violation.
# exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\Node;
  $pub = Node::create(["type" => "article", "title" => "ROP enforce check pub", "status" => 1]);
  $vp = $pub->validate();
  $hitPub = 0; foreach ($vp as $x) { if ($x->getPropertyPath() === "field_rop_enf") { $hitPub++; } }
  $unpub = Node::create(["type" => "article", "title" => "ROP enforce check unpub", "status" => 0]);
  $vu = $unpub->validate();
  $hitUnpub = 0; foreach ($vu as $x) { if ($x->getPropertyPath() === "field_rop_enf") { $hitUnpub++; } }
  $ok = ($hitPub >= 1 && $hitUnpub === 0);
  print ($ok ? "PASS" : "FAIL") . " violations_published=" . $hitPub . " violations_unpublished=" . $hitUnpub . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
