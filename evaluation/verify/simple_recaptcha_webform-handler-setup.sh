#!/usr/bin/env bash
# Introspection SETUP: create a webform srw_known with the simple_recaptcha handler (v3, score 88). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  if (!Webform::load("srw_known")) {
    $w = Webform::create(["id"=>"srw_known","title"=>"SRW Known"]);
    $w->save();
    $handler = \Drupal::service("plugin.manager.webform.handler")->createInstance("simple_recaptcha", [
      "id"=>"simple_recaptcha","handler_id"=>"srw_captcha","label"=>"reCAPTCHA","status"=>TRUE,"weight"=>0,
      "settings"=>["recaptcha_type"=>"v3","v3_score"=>88,"v3_error_message"=>"Please retry.","hide_badge_v3"=>FALSE],
    ]);
    $w->addWebformHandler($handler);
    $w->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: webform srw_known has simple_recaptcha handler (v3, score 88)"
