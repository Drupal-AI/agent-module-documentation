A meta-module that turns on every production-ready Audit analyzer in one step.

---

`audit_all` ships no analyzer of its own. Its only purpose is a dependency list: enabling it installs `audit` plus every production analyzer submodule (blocks, cache, cron, database, entity, fields, i18n, images, menu, modules, performance, security, seo, status, twig, updates, url, views, watchdog). It intentionally excludes the dev-only code-analysis analyzers (audit_phpcs, audit_phpstan, audit_phpunit, audit_complexity, audit_duplication) that need external tools (phpcs, phpstan, phpunit, phploc, jscpd) not present on production.

---

- Enable a full production audit in one command: `drush en audit_all`.
- Get every production analyzer registered without listing them individually.
- Populate the Reports > Audit table with all standard checks at once.
- Use as the baseline install when taking over an unfamiliar site.
- Avoid pulling in dev-only tools (phpcs/phpstan/phpunit/phploc/jscpd) on production.
- Pair with `Run all audits` to compute a complete Project Score.
- Uninstall it to keep the analyzers (it only carries dependencies) or disable analyzers individually.
- Add the dev analyzers separately in staging when you need code-quality gates.
