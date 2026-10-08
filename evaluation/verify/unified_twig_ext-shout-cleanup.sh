#!/usr/bin/env bash
# Execution CLEANUP (unified_twig_ext): restore default=olivero, uninstall ute_twig, remove the theme
# directory. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cfg=\Drupal::configFactory()->getEditable("system.theme");
  if($cfg->get("default")==="ute_twig"){$cfg->set("default","olivero")->save();}
  if(\Drupal::service("theme_handler")->themeExists("ute_twig")){try{\Drupal::service("theme_installer")->uninstall(["ute_twig"]);}catch(\Throwable $e){}}
' >/dev/null 2>&1
rm -rf web/themes/custom/ute_twig
drush cr >/dev/null 2>&1
echo "cleanup: ute_twig removed, default=olivero"
