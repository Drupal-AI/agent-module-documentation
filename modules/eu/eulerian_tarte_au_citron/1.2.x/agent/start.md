<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tarte au citron Eulerian (eulerian_tarte_au_citron) — agent index

Bridge module that registers **Eulerian analytics** as a consent-gated service in the **Tarte au citron**
consent manager. When consent is required (the default) the Eulerian tag is not fired on page load; it is built
and pushed only after the visitor consents through the Tarte au citron banner. Package `GDPR`. License
GPL-2.0-or-later. Version 1.2.1. Core `^10.3 || ^11 || ^12`.

## Dependencies

- `eulerian:eulerian` — provides the Eulerian tag, its admin config, and `drupalSettings.eulerian` (collect
  `domain` + `datalayer`). Composer `drupal/eulerian:^1.0`.
- `tarte_au_citron:tarte_au_citron` — the consent manager and the `ServicePluginBase` / service-plugin type this
  module extends. Composer `drupal/tarte_au_citron:^1.0 || ^2.0 || ^3.0`.

## What it provides (from source)

- **One Tarte au citron service plugin**: `Drupal\eulerian_tarte_au_citron\Plugin\tarte_au_citron\Eulerian`
  (id `eulerian-analytics`, title *Eulerian Analytics*), extending `tarte_au_citron`'s `ServicePluginBase`. Adds
  a **"Need consent"** checkbox and selects which JS library loads. → [plugins/eulerian-service.md](plugins/eulerian-service.md)
- **Three hooks** in `src/Hook/EulerianTarteAuCitronHooks.php` (attribute `#[Hook]`, autowired service; legacy
  wrappers in the `.module`): `help`, `library_info_alter`, `page_attachments_alter`. These swap/remove the
  `eulerian/init` library depending on the consent setting. → [behavior/consent-gating.md](behavior/consent-gating.md)
- **Two JS libraries** (`eulerian_tarte_au_citron.libraries.yml`): `service.eulerian` and `service.tarte_au_citron`,
  each registering `tarteaucitron.services['eulerian-analytics']`. → [behavior/consent-gating.md](behavior/consent-gating.md)

## What it does NOT provide

No routes, no controllers, no permissions, no forms of its own, no config objects, **no config schema**, no
`config/install`, no entities, no services beyond the hook class, no Drush. `configure` is null — the plugin's
one setting is stored inside the base `tarte_au_citron.settings` config, edited on the Tarte au citron admin
screen. It has no access-control role.

## Install / operate

1. `composer require drupal/eulerian_tarte_au_citron` (pulls `drupal/eulerian` + `drupal/tarte_au_citron`).
2. `drush en eulerian_tarte_au_citron -y`.
3. Configure the **Eulerian** module (collect domain) and set up **Tarte au citron** (banner + services).
4. In Tarte au citron's service settings, confirm *Eulerian Analytics* is enabled; leave *Need consent* on to
   gate the tag, or turn it off to run Eulerian without consent (TCFv2). Clear caches after enable/disable.
