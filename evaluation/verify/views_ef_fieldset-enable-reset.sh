#!/usr/bin/env bash
# Execution RESET: (re)create the vef_test view with the Views EF Fieldset extender present but
# DISABLED (enabled=false), so verify FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  use Symfony\Component\Yaml\Yaml;
  $p = DRUPAL_ROOT . "/modules/contrib/views_ef_fieldset/tests/modules/test_views_ef_fieldset/config/install/views.view.test_views_ef_fieldset.yml";
  $data = Yaml::parse(file_get_contents($p));
  $data["id"] = "vef_test";
  $data["label"] = "VEF Test";
  unset($data["uuid"], $data["_core"]);
  $data["display"]["default"]["display_options"]["display_extenders"]["views_ef_fieldset"]["views_ef_fieldset"]["enabled"] = FALSE;
  if ($v = View::load("vef_test")) { $v->delete(); }
  View::create($data)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vef_test created with views_ef_fieldset enabled=FALSE"
