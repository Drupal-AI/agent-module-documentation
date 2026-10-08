#!/usr/bin/env bash
# Introspection SETUP: ensure the shipping submodule is enabled (idempotent). No config mutation;
# the class override is inherent to the enabled module.
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx commerce_currency_resolver_shipping \
  || drush en commerce_currency_resolver_shipping -y >/dev/null 2>&1
echo "setup: commerce_currency_resolver_shipping enabled"
