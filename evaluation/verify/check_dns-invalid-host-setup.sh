#!/usr/bin/env bash
# Introspection SETUP (check_dns): ensure check_dns is enabled. Known fact to read
# back: the reserved, non-resolving domain 'no-such-domain-xyz123abc.invalid' is
# rejected by check_dns.service->validateHost(). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush -y en check_dns >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: check_dns enabled; validateHost('no-such-domain-xyz123abc.invalid') is discoverable"
