#!/usr/bin/env bash
# Execution RESET: (re)create webform srw_task WITHOUT any simple_recaptcha handler so verify FAILS. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  if ($w = Webform::load("srw_task")) { $w->delete(); }
  Webform::create(["id"=>"srw_task","title"=>"SRW Task"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: webform srw_task exists with no reCAPTCHA handler"
