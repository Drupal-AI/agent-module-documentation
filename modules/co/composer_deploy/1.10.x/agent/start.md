# composer_deploy — agent start

Restores version numbers to Composer-installed modules/themes so `admin/reports/updates`
shows real releases. No UI, no permissions, no Drush. It reads `vendor/composer/installed.json`
and injects `version` / `project` / `datestamp` / `composer_deploy_git_hash` into any extension
whose `.info.yml` has an empty `version` (i.e. Composer installs, not Drupal.org tarballs).
Enable it and it just works.

- How the version injection works + what keys it adds → [api/version-injection.md](api/version-injection.md)
- The one config key (`prefixes`) — read it, change it → [extend/prefixes.md](extend/prefixes.md)

It only acts when `empty($info['version'])`, so tarball-packaged releases (which already carry
a version) are left untouched — Composer `dev-`/git installs are where it does its work.
