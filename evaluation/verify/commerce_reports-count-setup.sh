#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("commerce_order_report");
  foreach ($s->loadByProperties(["mail" => "creport-count@example.test"]) as $e) { $e->delete(); }
  foreach ([4242, 4243, 4244] as $oid) {
    $s->create(["type"=>"order_report","order_id"=>$oid,"amount"=>["number"=>"10.00","currency_code"=>"USD"],"mail"=>"creport-count@example.test"])->save();
  }
' >/dev/null 2>&1
echo "setup: 3 order_report entities created (mail creport-count@example.test)"
