#!/usr/bin/env bash
# Introspection SETUP (check_dns): ensure the check_dns module is enabled so its
# check_dns.service is available for the agent to interrogate on the live site.
# The known, deterministic fact to read back: a real mail domain (drupal.org) is
# accepted by validateEmail(). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush -y en check_dns >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: check_dns enabled; check_dns.service->validateEmail('user@drupal.org') is discoverable"
