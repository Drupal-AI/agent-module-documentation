#!/usr/bin/env bash
# Execution RESET (unified_twig_ext): scaffold the ute_twig theme WITHOUT the ute_greeting function
# file (so verify FAILS), and make sure the site default theme is olivero. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
T=web/themes/custom/ute_twig
mkdir -p "$T/source/_twig-components/functions" "$T/source/_twig-components/filters" "$T/source/_twig-components/tags"
cat > "$T/ute_twig.info.yml" <<'YML'
name: UTE Twig Test
type: theme
base theme: stark
core_version_requirement: ^10 || ^11
YML
rm -f "$T/source/_twig-components/functions/ute_greeting.function.php"
drush php:eval '$cfg=\Drupal::configFactory()->getEditable("system.theme"); if($cfg->get("default")==="ute_twig"){$cfg->set("default","olivero")->save();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ute_twig scaffolded, no ute_greeting function file, default=olivero"
