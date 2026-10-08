<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Eulerian TacJS (eulerian_tacjs) — agent index

A **glue module** that registers the **Eulerian** analytics tag as a service inside the **TacJS
(Tarte au Citron)** consent manager, so the Eulerian tag loads according to visitor consent.
Package `Statistics`. Core `^10.1 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.1.0.

Depends on two contrib modules: **`eulerian`** (`drupal/eulerian ^1.0`) and **`tacjs`**
(`drupal/tacjs ^6.3`). No submodules.

- **Everything it does — hooks, the two JS loaders, the TacJS config keys it reads, and how to
  operate it** → [integration/service.md](integration/service.md)

## What it actually is

- **No routes, no controllers, no permissions, no forms, no config schema, no Drush, no plugins,
  no entities, no fields.** The `configure` link in `.info.yml` (`eulerian.settings_form`) points
  at the **Eulerian module's** settings form, not one this module owns.
- All behaviour lives in **three hook implementations** (OO hooks via `#[Hook]` on
  `src/Hook/EulerianTacjsHooks.php`, with `#[LegacyHook]` shims in `eulerian_tacjs.module`) plus
  **two JS assets** declared in `eulerian_tacjs.libraries.yml`.
- One tiny interface, `src/ServiceInterface.php`, holds two constants: `NAME =
  'eulerian-analytics'` and `TYPE = 'analytic'` (the TacJS service key/type).

## Mechanism (from source)

- `hook_tacjs_content_alter()` unconditionally (re)defines the `analytic` → `eulerian-analytics`
  entry in the TacJS services list (name, privacy URL, `etuix` cookie, detection domain) and
  `ksort()`s the list.
- `hook_page_attachments_alter()` reads config **`tacjs.settings`** (owned by the TacJS module).
  If the Eulerian service is enabled there and the page already carries the `eulerian/init`
  library, it **swaps that library** for a consent-aware loader: `eulerian_tacjs/service.tarte_au_citron`
  when consent is required (`needConsent`), otherwise `eulerian_tacjs/service.eulerian`.
- Both JS files register `tarteaucitron.services['eulerian-analytics']` and, in their `js`
  callback, emit the standard Eulerian tag using **`drupalSettings.eulerian.domain`** /
  `drupalSettings.eulerian.datalayer` — values provided by the **Eulerian** module, not this one.

## Requirements & install

`composer require drupal/eulerian_tacjs` then `drush en eulerian_tacjs`. Configure the Eulerian
account/collect domain in the Eulerian module, then enable the Eulerian service (and choose its
"Need consent" option) on the TacJS configuration page. Details in
[integration/service.md](integration/service.md).
