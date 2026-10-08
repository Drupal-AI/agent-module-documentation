<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Eulerian TacJS — the integration in full

This module bridges two contrib modules: it takes the **Eulerian** tracking tag and registers it
as a consent-managed service in **TacJS** (the Drupal wrapper around the Tarte au Citron consent
manager). Nothing here is configurable inside this module; it only reacts to config owned by
Eulerian and TacJS.

## Files

- `src/Hook/EulerianTacjsHooks.php` — the class holding all three hooks (autowired service,
  `eulerian_tacjs.services.yml`; constructor injects `ConfigFactoryInterface $configFactory`).
- `eulerian_tacjs.module` — thin `#[LegacyHook]` procedural shims that delegate to the service
  (`\Drupal::service(EulerianTacjsHooks::class)->…`).
- `src/ServiceInterface.php` — constants `NAME = 'eulerian-analytics'`, `TYPE = 'analytic'`.
- `eulerian_tacjs.libraries.yml` — the two JS libraries.
- `js/service-eulerian.js`, `js/service-tarte-au-citron.js` — the two loaders.

## Install & enable

1. `composer require drupal/eulerian_tacjs` (pulls `drupal/eulerian ^1.0` and `drupal/tacjs ^6.3`).
2. `drush en eulerian_tacjs -y` (or via *Extend*). Both dependencies must be enabled.
3. Set the Eulerian **collect domain / account** in the **Eulerian** module's own settings
   (`eulerian.settings_form`). This module reads none of that itself — the JS reads it from
   `drupalSettings.eulerian`, which the Eulerian module populates.
4. On the **TacJS** configuration page, enable the *Eulerian* service and decide whether it
   requires consent (the "Need consent" checkbox). See "Config keys read" below.

## Hooks (all in `EulerianTacjsHooks`)

### `help()` — `#[Hook('help')]`
Returns a short "About" blurb only for route `help.page.eulerian_tacjs`; empty string otherwise.

### `tacjsContentAlter()` — `#[Hook('tacjs_content_alter')]`
Implements TacJS's `hook_tacjs_content_alter`. **Unconditionally overwrites** the service
definition at `$content['analytic']['eulerian-analytics']` (comment: "Even if the Eulerian service
already exists, we override it") with static values:

- `about.name` = `"Eulerian (privacy by design)"`,
  `about.privacy` = `https://eulerian.wiki/doku.php?id=en:modules:collect:gdpr:start`
- `code.js` / `code.html` = empty (the tag is injected by the JS loaders, not inline here)
- `cookies` = `['etuix']`
- `detection.domain` = `https://eulerian.com/rgpd`, `detection.tracker` = `''`

Then `ksort($content['analytic'])` re-alphabetises the analytics services list.

### `pageAttachmentsAlter()` — `#[Hook('page_attachments_alter')]`
The load-switch. Steps, in order:

1. Load config **`tacjs.settings`**.
2. If `services.eulerian-analytics.status` is falsy → **return** (service not enabled in TacJS;
   leave the page untouched).
3. If the page's `#attached['library']` does **not** contain `eulerian/init` → **return**
   (the Eulerian module hasn't attached its default init library on this page).
4. Branch on `services.eulerian-analytics.needConsent`:
   - **truthy (consent mandatory):** remove `eulerian/init` (via `array_search` + `unset`) and add
     **`eulerian_tacjs/service.tarte_au_citron`** — the Eulerian tag then fires only after the
     visitor grants consent through Tarte au Citron.
   - **falsy (consent-exempt):** keep the rest and add **`eulerian_tacjs/service.eulerian`** — the
     Eulerian tag is prepared to fire immediately (still routed through the TacJS service object).

Net effect: enabling the module means the raw `eulerian/init` autostart is replaced by a
consent-aware path. To restore Eulerian's default autostart, disable this module and rebuild caches
(per README).

## Config keys read (all in the `tacjs.settings` object, owned by the TacJS module)

- `services.eulerian-analytics.status` (bool) — is the Eulerian service enabled in TacJS.
- `services.eulerian-analytics.needConsent` (bool) — does it require explicit consent.

This module ships **no `config/install` and no `config/schema`** of its own; those keys are defined
and stored by TacJS.

## The two JS loaders (`eulerian_tacjs.libraries.yml`)

Both register `tarteaucitron.services['eulerian-analytics']` (key/type/name, `needConsent: true`,
`cookies: ['etuix']`, `uri: https://www.eulerian.com/rgpd`) and both short-circuit if
`drupalSettings.eulerian.domain` is undefined.

- **`service.eulerian`** (`js/service-eulerian.js`; deps: `core/drupalSettings`,
  `tacjs/tarteaucitron.js`) — its `js` callback injects the **standard Eulerian analytics tag**: it
  builds a `<script>` whose `src` is derived from `drupalSettings.eulerian.domain`, appends it to
  the page, then calls `EA_push(EA_prepare2Push(drupalSettings.eulerian.datalayer))`.
- **`service.tarte_au_citron`** (`js/service-tarte-au-citron.js`; deps: `core/drupalSettings`,
  `eulerian/events`, `eulerian/tools`, `tacjs/tarteaucitron.js`) — its `js` callback wires the
  Eulerian **generic CMP API** (`__eaGenericCmpApi`) to Tarte au Citron consent events
  (`tac.close_alert`, `tac.close_panel`) so Eulerian receives the consent signal; it does not build
  the script tag itself. A `fallback` re-invokes `js()`.

The Eulerian collect `domain` and `datalayer` are always sourced from `drupalSettings.eulerian`
(populated by the Eulerian module from its admin config) — this module never sets or accepts those
values.

## Operating notes

- Order matters: the Eulerian module must be the one attaching `eulerian/init` on the page, or
  `pageAttachmentsAlter()` returns early and no swap happens.
- The TacJS service key is the literal `eulerian-analytics` (`ServiceInterface::NAME`); the type is
  `analytic` (`ServiceInterface::TYPE`). Changing consent behaviour is done entirely on the TacJS
  service form, not here.
- "Need consent" exemption is a legal/compliance choice — the module supports both modes; consult
  the CNIL/Eulerian guidance referenced in the README before running consent-exempt.
