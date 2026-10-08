#!/usr/bin/env bash
# Execution VERIFY: PASS when an ACTIVE role-type commerce_license granting the
# commerce_license_member role exists. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("commerce_license");
  $ids = $storage->getQuery()->accessCheck(FALSE)->condition("type", "role")->execute();
  $ok = FALSE; $info = "";
  foreach ($storage->loadMultiple($ids) as $l) {
    if ($l->license_role->target_id === "commerce_license_member") {
      $info = "state=" . $l->getState()->getId() . " role=" . $l->license_role->target_id;
      if ($l->getState()->getId() === "active") { $ok = TRUE; break; }
    }
  }
  print ($ok ? "PASS " : "FAIL ") . $info . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
