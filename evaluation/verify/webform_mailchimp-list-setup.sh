#!/usr/bin/env bash
# Introspection SETUP: webform wmc_known with a mailchimp handler targeting a known list. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  if (!Webform::load("wmc_known")) {
    $w = Webform::create(["id"=>"wmc_known","title"=>"WMC Known"]);
    $w->save();
    $h = \Drupal::service("plugin.manager.webform.handler")->createInstance("mailchimp", [
      "id"=>"mailchimp","handler_id"=>"mc","label"=>"MailChimp","status"=>TRUE,"weight"=>0,
      "settings"=>["list"=>"eval_audience_9","email"=>"email","double_optin"=>TRUE,"mergevars"=>"","interest_groups"=>[],"control"=>""],
    ]);
    $w->addWebformHandler($h);
    $w->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: webform wmc_known mailchimp handler list=eval_audience_9"
