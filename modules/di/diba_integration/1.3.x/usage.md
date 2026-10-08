DiBa Integration is a site-setup and services meta-module that standardizes Diputació de Barcelona (DiBa) Drupal platforms by bundling hardening/utility contrib modules, adding configuration health checks, and shipping optional SAML SSO, VUS validation, and Google Tag Manager cookie-consent submodules.

---

The base `diba_integration` module carries no routes or forms of its own. On install it pulls in a curated dependency set (Admin Toolbar, Antibot, Honeypot, Backup and Migrate, Masquerade, Pathauto, Reroute Email, Role Delegation, Simple Sitemap, YASM, No 404 Log, plus core Automated Cron, Locale and Syslog). Its `DibaIntegrationHooks` (`#[Hook]` attribute methods) run two behaviors: `hook_cron` delegates to `DibaIntegrationMaintenanceService` to delete `bam*` files older than one week and to wipe the whole `temporary://` directory (except `.htaccess`) older than three months; `hook_page_attachments_alter` strips the `system_meta_generator` (`<meta name="generator">`) tag from every page to reduce version fingerprinting. `hook_requirements` adds runtime status-report checks: unused-file purging, minimum role/user counts, a `@diba.cat` site-mail check, missing-schema-module detection, and filename-sanitization recommendations. A small `status_card` CSS library themes the submodule settings-form status banners. Three functional submodules build on this base — `diba_integration_saml` (corporate SAML SSO via samlauth), `diba_integration_vus` (VUS web-service + Oracle user validation and auto-provisioning), and `diba_integration_cogo` (GTM with a cookie-consent banner) — plus `diba_integration_extra`, a D10-only bundle of legacy add-ons.

---

- Bootstrap a new DiBa-standard Drupal site with one dependency install (admin toolbar, anti-spam, backup, sitemap, etc.).
- Enforce consistent baseline hardening (Antibot + Honeypot on forms, Reroute Email in non-production, Role Delegation for delegated user management).
- Automatically purge stale `temporary://` files and orphaned Backup and Migrate (`bam*`) temp files on cron to stop the temp directory growing unbounded.
- Remove the `<meta name="generator">` tag site-wide to reduce Drupal version disclosure.
- Surface site-configuration health warnings on `/admin/reports/status` (roles, users, site mail, unused-file deletion, filename sanitization).
- Warn administrators when a module still has a `system.schema` entry but its files are missing.
- Nudge operators to set `make_unused_managed_files_temporary` so unused managed files are cleaned up.
- Recommend enabling all filename-sanitization options (transliterate, replace whitespace, lowercase, replace non-alphanumeric).
- Add corporate SAML single sign-on to a DiBa site via the `diba_integration_saml` submodule (delegating protocol validation to samlauth).
- Import raw IdP metadata XML and auto-populate IdP entity ID, SSO/SLO URLs and certificate.
- Generate multi-environment SP metadata XML for registration with the corporate IdP.
- Enforce hybrid login policy: corporate-domain users go to SAML, others use local Drupal login, with an exempt-usernames escape list.
- Validate site users against the DiBa VUS corporate web service and optionally auto-provision Drupal accounts on first login.
- Single-sign-on into a DiBa site by POSTing corporate `user`/`pass` credentials (VUS SSO mode).
- Synchronize VUS "ens" (organizations) and "perfils" (profiles) into taxonomy vocabularies referenced from user accounts.
- Cross-check Drupal accounts against the DiBa Oracle mailbox directory in an admin "busties" (mailboxes) search, statistics, and mismatch-error report.
- Block corporate users from resetting their password through Drupal and redirect them to the corporate portal.
- Add a Google Tag Manager container with a Consent Mode v2 default/accept/reject configuration.
- Show a multilingual (ca/es/en) cookie-consent banner with a configurable privacy-policy link and expiry.
- Add the Google site-verification meta tag through configuration.
- Bundle legacy D10-only helpers (DiBa Carousel, Responsive Wrappers) via `diba_integration_extra`.
