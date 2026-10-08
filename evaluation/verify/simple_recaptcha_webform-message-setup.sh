#!/usr/bin/env bash
# Introspection SETUP: create webform srw_msg with a simple_recaptcha handler carrying a known
# custom v3 error message. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  if (!Webform::load("srw_msg")) {
    $w = Webform::create(["id"=>"srw_msg","title"=>"SRW Msg"]);
    $w->save();
    $handler = \Drupal::service("plugin.manager.webform.handler")->createInstance("simple_recaptcha", [
      "id"=>"simple_recaptcha","handler_id"=>"srw_captcha","label"=>"reCAPTCHA","status"=>TRUE,"weight"=>0,
      "settings"=>["recaptcha_type"=>"v3","v3_score"=>90,"v3_error_message"=>"Bots are not welcome here.","hide_badge_v3"=>FALSE],
    ]);
    $w->addWebformHandler($handler);
    $w->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: webform srw_msg handler v3_error_message='Bots are not welcome here.'"
