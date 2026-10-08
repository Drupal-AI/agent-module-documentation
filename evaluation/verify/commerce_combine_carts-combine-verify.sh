#!/usr/bin/env bash
# Execution VERIFY: PASS when the ccc_task_user@example.com account has exactly ONE cart (the two
# same-type carts were combined). Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\User;
  $ids = \Drupal::entityQuery("user")->condition("mail", "ccc_task_user@example.com")->accessCheck(FALSE)->execute();
  $u = $ids ? User::load(reset($ids)) : NULL;
  $n = -1;
  if ($u) {
    $cp = \Drupal::service("commerce_cart.cart_provider");
    $cp->clearCaches();
    $n = count($cp->getCarts($u));
  }
  $ok = ($n === 1);
  print ($ok ? "PASS" : "FAIL") . " user=" . ($u ? "present" : "absent") . " carts=" . $n . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
