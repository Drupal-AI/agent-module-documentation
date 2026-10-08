#!/usr/bin/env bash
# Introspection SETUP: webform wmc_optin with a mailchimp handler, double opt-in OFF,
# email element 'contact_email'. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  if (!Webform::load("wmc_optin")) {
    $w = Webform::create(["id"=>"wmc_optin","title"=>"WMC Optin"]);
    $w->save();
    $h = \Drupal::service("plugin.manager.webform.handler")->createInstance("mailchimp", [
      "id"=>"mailchimp","handler_id"=>"mc","label"=>"MailChimp","status"=>TRUE,"weight"=>0,
      "settings"=>["list"=>"eval_audience_2","email"=>"contact_email","double_optin"=>FALSE,"mergevars"=>"","interest_groups"=>[],"control"=>""],
    ]);
    $w->addWebformHandler($h);
    $w->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: webform wmc_optin mailchimp handler double_optin=false email=contact_email"
