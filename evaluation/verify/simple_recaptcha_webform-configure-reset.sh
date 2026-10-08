#!/usr/bin/env bash
# Execution RESET: (re)create webform srw_cfg with NO reCAPTCHA handler so verify FAILS. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  if ($w = Webform::load("srw_cfg")) { $w->delete(); }
  Webform::create(["id"=>"srw_cfg","title"=>"SRW Cfg"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: webform srw_cfg exists with no reCAPTCHA handler"
