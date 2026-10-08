<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DiBa Integration (diba_integration) — agent index

Site-setup and services meta-module for Diputació de Barcelona (DiBa) Drupal platforms. Core `^10.3 || ^11 || ^12`, package `diba`, license GPL-2.0-or-later. No routes/permissions/config of its own in the base module.

## What the base module does
- **Dependency bundle** (info.yml `dependencies` / composer `require`): admin_toolbar, antibot, backup_migrate, honeypot, masquerade, pathauto, reroute_email, role_delegation, simple_sitemap, yasm, no_404_log, plus core automated_cron, locale, syslog. Enabling `diba_integration` enables the whole hardening/utility stack.
- **Maintenance cron** — `Service/DibaIntegrationMaintenanceService`: `cron()` purges `temporary://` `bam*` files older than 1 week and the whole temp dir (except `.htaccess`) older than 3 months, throttled via the `state` keys `diba_integration.cron_bam_tmp_check` / `.cron_tmp_check`.
- **Generator meta removal** — `removeGeneratorMeta()` deletes the `system_meta_generator` head element (version fingerprint reduction).
- **Health checks** — `diba_integration.install` `hook_requirements` (runtime): unused-file deletion, role count ≥4, user count ≥3, site mail ends `@diba.cat`, missing-schema modules, filename-sanitization options.
- Hooks wired via `#[Hook]` in `src/Hook/DibaIntegrationHooks.php` (`cron`, `page_attachments_alter`); services in `diba_integration.services.yml` (both autowired). Library `status_card` (css/status-card.css) themes submodule form status banners.

## Services
- `Drupal\diba_integration\Service\DibaIntegrationMaintenanceService` — temp/bam cleanup + generator-meta removal.
- `Drupal\diba_integration\Hook\DibaIntegrationHooks` — hook handler.

## Submodules (each documented in its own tree under `modules/diba_integration_*/1.3.x/`)
- **diba_integration_saml** — corporate SAML SSO, delegates protocol validation to `samlauth`; login-form policy (local/combined/hybrid), IdP-metadata import, multi-env SP metadata.
- **diba_integration_vus** — VUS corporate validation via SOAP-ish web service (`GuzzleHttp`) + Oracle (`oci_*`) mailbox directory; login integration, auto-provisioning, ens/perfils taxonomy sync, admin busties/counts/errors reports.
- **diba_integration_cogo** — Google Tag Manager + multilingual cookie-consent banner (Consent Mode v2).
- **diba_integration_extra** — D10-only legacy add-on bundle (diba_carousel, responsivewrappers).

## Solution docs
- `agent/config/settings.md` — base-module behavior: cron cleanup, hook_requirements checks, generator-meta removal, operating notes.
