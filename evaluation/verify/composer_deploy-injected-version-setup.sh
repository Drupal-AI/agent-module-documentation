#!/usr/bin/env bash
# Medium (introspection) SETUP for composer_deploy version injection.
# The fact under test is a live, static property of the deployed site: votingapi is
# installed from a Composer dev branch (no version in its .info.yml), so composer_deploy
# fills its version + composer_deploy_git_hash from vendor/composer/installed.json.
# This setup just guarantees the fact is discoverable: composer_deploy enabled and the
# extension-info cache rebuilt so getExtensionInfo() returns the injected values.
set -uo pipefail
cd /var/www/html
drush pm:enable composer_deploy -y >/dev/null 2>&1
drush pm:enable votingapi -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: composer_deploy + votingapi enabled, caches rebuilt (injected version discoverable)"
