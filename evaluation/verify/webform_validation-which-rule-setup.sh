#!/usr/bin/env bash
# Introspection SETUP: create webform wfv_known with two email elements where wfv_confirm
# carries a webform_validation "Equal values" rule against wfv_email, so an inspecting agent
# can read the configured cross-field validation. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  if (!Webform::load("wfv_known")) {
    $w = Webform::create(["id" => "wfv_known", "title" => "WFV Known"]);
    $w->setElements([
      "wfv_email" => ["#type" => "email", "#title" => "Email"],
      "wfv_confirm" => [
        "#type" => "email", "#title" => "Confirm email",
        "#equal__enabled" => 1,
        "#equal__components" => ["wfv_email" => "wfv_email"],
      ],
    ]);
    $w->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: webform wfv_known - wfv_confirm has equal rule vs wfv_email"
