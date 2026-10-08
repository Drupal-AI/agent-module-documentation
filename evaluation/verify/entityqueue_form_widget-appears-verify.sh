#!/usr/bin/env bash
# Execution VERIFY: PASS when, on an Article node add form, the Entityqueue Form Widget offers
# a checkbox for the eqfw_task queue. Renders the form as user 1 (superuser, so the per-queue
# permission-gated checkbox is included) and checks
# $form['entityqueue_form_widget']['entityqueues']['eqfw_task']. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $account = \Drupal\user\Entity\User::load(1);
  $switcher = \Drupal::service("account_switcher");
  $switcher->switchTo($account);
  $node = \Drupal::entityTypeManager()->getStorage("node")->create(["type" => "article", "title" => "eqfw probe"]);
  $form = \Drupal::service("entity.form_builder")->getForm($node, "default");
  $switcher->switchBack();
  $has_group = isset($form["entityqueue_form_widget"]);
  $has_cb = isset($form["entityqueue_form_widget"]["entityqueues"]["eqfw_task"]);
  $ok = $has_group && $has_cb;
  print ($ok ? "PASS" : "FAIL") . " group=" . ($has_group ? "1" : "0") . " checkbox_eqfw_task=" . ($has_cb ? "1" : "0") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
