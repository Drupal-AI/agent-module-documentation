#!/usr/bin/env bash
# Execution VERIFY: PASS when ng_lightbox is configured to use the non-modal Core Dialog
# renderer at 500px — checked both in config (renderer=drupal_dialog, default_width=500) and
# behaviourally, by asking the live ng_lightbox service to decorate a link and asserting it gets
# class use-ajax, data-dialog-type "dialog" and width 500 in data-dialog-options.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("ng_lightbox.settings");
  $link = ["options" => []];
  \Drupal::service("ng_lightbox")->addLightbox($link);
  $attr = $link["options"]["attributes"];
  $opts = json_decode($attr["data-dialog-options"], TRUE);
  $ok = $c->get("renderer") === "drupal_dialog"
    && (int) $c->get("default_width") === 500
    && in_array("use-ajax", $attr["class"], TRUE)
    && ($attr["data-dialog-type"] ?? NULL) === "dialog"
    && (int) ($opts["width"] ?? 0) === 500;
  print ($ok ? "PASS" : "FAIL")
    . " renderer=" . var_export($c->get("renderer"), TRUE)
    . " width=" . var_export($c->get("default_width"), TRUE)
    . " dialog_type=" . var_export($attr["data-dialog-type"] ?? NULL, TRUE)
    . " dialog_options=" . $attr["data-dialog-options"] . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
