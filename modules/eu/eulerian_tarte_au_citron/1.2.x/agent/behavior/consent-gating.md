<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Consent-gating behavior: hooks + JS

The module makes Eulerian consent-aware by (a) rewiring the `eulerian/init` library in PHP hooks and (b) shipping
two JS libraries that register the Eulerian tag with `tarteaucitron`. All logic keys off the plugin setting
`tarte_au_citron.settings:services_settings.eulerian-analytics.need_consent`.

## Hooks — `src/Hook/EulerianTarteAuCitronHooks.php`

Autowired service (`eulerian_tarte_au_citron.services.yml`, `autowire: true`); the `.module` file only holds
`#[LegacyHook]` wrappers that delegate to it. Constructor injects `ConfigFactoryInterface $configFactory` and the
`tarte_au_citron.services_manager` (`ServicesManagerInterface $servicesManager`).

- **`help`** (`#[Hook('help')]`) — for `help.page.eulerian_tarte_au_citron` returns a static translated "About"
  string; otherwise `''`.
- **`library_info_alter`** (`#[Hook('library_info_alter')]`) — when `$extension === 'eulerian'` **and**
  `need_consent` is falsy, appends `eulerian_tarte_au_citron/service.eulerian` to Eulerian's `init` library
  dependencies, so the consent-exempt bridge loads with Eulerian's own init.
- **`page_attachments_alter`** (`#[Hook('page_attachments_alter')]`) — returns early unless the services manager
  says Tarte au citron `isNeeded()` and `isServiceEnabled('eulerian-analytics')`, and unless `eulerian/init` is
  actually among the attached libraries. Then, **if `need_consent` is TRUE**, it locates and `unset()`s the
  `eulerian/init` library from `$attachments['#attached']['library']` — removing Eulerian's default page-load tag
  so Tarte au citron's consent-gated registration (below) controls loading instead.

Net effect: consent required → Eulerian's page-load init is stripped and the tag is deferred to consent;
consent not required → Eulerian's init runs and the CMP-bridge library is attached alongside it.

## JS libraries — `eulerian_tarte_au_citron.libraries.yml`

Both are `header: true` and register `tarteaucitron.services['eulerian-analytics']` (type `analytic`, cookie
`etuix`, `needConsent: true`, info URI `https://www.eulerian.com/rgpd`). The Eulerian collect domain and
datalayer are read from `drupalSettings.eulerian.domain` / `drupalSettings.eulerian.datalayer`, which are
populated by the **base Eulerian module** (this module neither stores nor accepts them). Each `js()` returns
early if `drupalSettings.eulerian.domain` is undefined.

- **`service.tarte_au_citron`** (`js/service-tarte-au-citron.js`; deps: `core/drupalSettings`, `eulerian/events`,
  `eulerian/tools`, `tarte_au_citron/tarte_au_citron_lib`) — the consent-gated path (`need_consent` TRUE). On
  consent, runs Eulerian's standard collect-tag bootstrap that injects a `<script>` whose src is derived from
  `drupalSettings.eulerian.domain` (protocol-relative `//` → inherits the page scheme), then calls
  `EA_push(EA_prepare2Push(drupalSettings.eulerian.datalayer))`.
- **`service.eulerian`** (`js/service-eulerian.js`; deps: `core/drupalSettings`, `tarte_au_citron/tarte_au_citron_lib`)
  — the consent-exempt path (`need_consent` FALSE). Wires Eulerian's `__eaGenericCmpApi` bridge and re-invokes it
  on `tac.close_alert` / `tac.close_panel` window events so Eulerian's own TCFv2 CMP handling drives collection.

## Operating notes

- The module has no settings page of its own; enable/disable + the *Need consent* checkbox (on the Tarte au
  citron service settings) are the only controls. Clear caches after enabling or disabling so library alterations
  take effect (per README).
- Disabling this module restores Eulerian's default immediate tag loading.
