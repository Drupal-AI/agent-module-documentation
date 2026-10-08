#!/usr/bin/env bash
# Introspection SETUP: create a namespaced view 'vef_test' (from the module's shipped test view)
# with the Views EF Fieldset extender ENABLED and a distinctive root fieldset title
# 'vef_root_marker', so an inspecting agent can read the grouping config back. Idempotent. Exit 0.
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
  $ext = &$data["display"]["default"]["display_options"]["display_extenders"]["views_ef_fieldset"]["views_ef_fieldset"];
  $ext["enabled"] = TRUE;
  $ext["options"]["sort"]["root"]["title"] = "vef_root_marker";
  unset($ext);
  if ($v = View::load("vef_test")) { $v->delete(); }
  View::create($data)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vef_test created with views_ef_fieldset enabled, root title vef_root_marker"
