#!/usr/bin/env bash
# Execution VERIFY: PASS when some enabled module implements
# hook_facebook_pixel_event_data_alter() such that queueing a Purchase event through the
# facebook_pixel.facebook_event service adds fbp_eval_marker = "ok" to the payload, while a
# ViewContent event is left untouched. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $mh = \Drupal::moduleHandler();
  $implemented = $mh->hasImplementations("facebook_pixel_event_data_alter");
  $purchase = ["value" => "10.00", "currency" => "EUR"];
  $mh->invokeAll("facebook_pixel_event_data_alter", [&$purchase, "Purchase"]);
  $view = ["content_name" => "probe"];
  $mh->invokeAll("facebook_pixel_event_data_alter", [&$view, "ViewContent"]);
  $marked = (($purchase["fbp_eval_marker"] ?? NULL) === "ok");
  $untouched = !isset($view["fbp_eval_marker"]);
  $ok = $implemented && $marked && $untouched;
  print ($ok ? "PASS" : "FAIL") . " hook_implemented=" . ($implemented ? "yes" : "no")
    . " purchase_marker=" . var_export($purchase["fbp_eval_marker"] ?? NULL, TRUE)
    . " viewcontent_untouched=" . ($untouched ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
