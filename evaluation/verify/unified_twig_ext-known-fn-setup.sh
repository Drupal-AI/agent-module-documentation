#!/usr/bin/env bash
# Introspection SETUP (unified_twig_ext): scaffold a namespaced custom theme ute_twig containing one
# unified_twig_ext-style Twig FUNCTION file, so an agent can inspect the theme and read the function
# name it would register. Non-invasive (theme is NOT installed or made default). Idempotent. Exit 0.
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
cat > "$T/source/_twig-components/functions/ute_known.function.php" <<'PHP'
<?php
$function = new \Twig\TwigFunction('ute_known_fn', function () {
  return 'ute-known-value';
});
PHP
echo "setup: ute_twig theme has functions/ute_known.function.php registering Twig function ute_known_fn"
