#!/usr/bin/env bash
# Introspection SETUP (unified_twig_ext): scaffold ute_twig theme with one unified_twig_ext-style
# Twig FILTER file so an agent can inspect the theme and read the filter name. Non-invasive. Exit 0.
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
cat > "$T/source/_twig-components/filters/ute_known.filter.php" <<'PHP'
<?php
$filter = new \Twig\TwigFilter('ute_known_filter', function ($s) {
  return strrev((string) $s);
});
PHP
echo "setup: ute_twig theme has filters/ute_known.filter.php registering Twig filter ute_known_filter"
