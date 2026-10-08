#!/usr/bin/env bash
# Introspection SETUP: create webform wfv_compare with two number elements where wfv_max
# carries a webform_validation "Compare" rule (wfv_max must be > wfv_min), so an inspecting
# agent can read the operator and target. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  if (!Webform::load("wfv_compare")) {
    $w = Webform::create(["id" => "wfv_compare", "title" => "WFV Compare"]);
    $w->setElements([
      "wfv_min" => ["#type" => "number", "#title" => "Minimum"],
      "wfv_max" => [
        "#type" => "number", "#title" => "Maximum",
        "#compare__enabled" => 1,
        "#compare__component" => "wfv_min",
        "#compare__operator" => ">",
      ],
    ]);
    $w->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: webform wfv_compare - wfv_max compare vs wfv_min operator >"
