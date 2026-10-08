<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Adnuntius (adnuntius) — agent index

Renders **Adnuntius.com ad units** in Drupal as a **block** or an **entity field**. An admin defines
a catalog of ad units (label, `auId`, width, height, weight); each placement emits a themed inline
snippet that loads Adnuntius' client-side `adn.js` from `cdn.adnuntius.com`. Depends on core
**`block`** and **`field`**. Config at `adnuntius.settings`. License GPL-2.0-or-later. Version
8.x-1.0-beta6. Core `^9.1 || ^10 || ^11 || ^12`. **No server-side API call, no stored key** — ad
delivery is entirely client-side.

- **Settings form, config objects/schema, permissions, the manager service, block & field plugins,
  theming** → [config/settings.md](config/settings.md)

## What it actually is

- **One config form** `AdnuntiusSettingsForm` (`src/Form/AdnuntiusSettingsForm.php`) at route
  `adnuntius.settings` → `/admin/config/services/adnuntius`, permission **`administer adnuntius`**.
  Writes the config object **`adnuntius.settings`** (`ad_units` sequence). (README says
  `/admin/structure/services/...` — that is wrong; the routing file uses `/admin/config/services/...`.)
- **One service** `adnuntius.manager` → `Drupal\adnuntius\AdnuntiusManager` (interface
  `AdnuntiusManagerInterface`), args `@config.factory`, `@renderer`. Reads ad units from config and
  builds the `#theme => 'adnuntius'` render array.
- **One block plugin** `AdnuntiusBlock` (id `adnuntius_block`) — pick an ad unit + invocation method.
- **One field** — type `AdnuntiusItem` (id `adnuntius`, columns `auid`, `invocation_method`), widget
  `AdnuntiusWidget` (id `adnuntius`), formatter `AdnuntiusFormatter` (id `adnuntius`).
- **One theme hook** `adnuntius` (`adnuntius.module` `hook_theme`) + template
  `templates/adnuntius.html.twig`, with suggestions `adnuntius__<invocation_method>` and
  `adnuntius__<auid>`.
- **Two permissions** (`adnuntius.permissions.yml`): `administer adnuntius`, `use adnuntius field`.
- **Config schema** in `config/schema/adnuntius.schema.yml` (config object + block/field/widget/
  formatter settings). No install config, no `.install`, no Drush, no submodules.

## Mechanism (from source)

- `AdnuntiusManager::getAdUnits()` returns `adnuntius.settings.ad_units`; `getAdUnit($auId)` returns
  one keyed entry or NULL. `getInvocationMethodOptionList()` is a fixed list: `iframe`, `div`.
- `render($auId, $invocation_method)` builds output **only if `getAdUnit($auId)` matches**, and fills
  `#auid`, `#width`, `#height` from the **stored ad unit** (not from caller input); adds the config
  object as a cacheable dependency.
- `AdnuntiusBlock::build()` reads block config `auid` + `invocation_method` and calls
  `render()`; `blockForm()` offers `auid` as a **select** of configured units and
  `invocation_method` as a select of iframe/div.
- `AdnuntiusFormatter::viewElements()` calls `render($values['auid'], $method)` per field item;
  `$method` is the formatter's `invocation_method` setting, overridden by the entity's value only
  when the field setting `invocation_method_per_entity` is on.
- `AdnuntiusWidget::formElement()` offers `auid` as a select (or textfield if no units configured)
  gated `#access => hasPermission('use adnuntius field')`; optional per-entity `invocation_method`
  select, whitelistable per field.
- The Twig template writes an `<div id="adn-{{ auid }}">` plus an inline `<script>` that injects
  `adn.js` and calls `adn.request({ adUnits: [{ auId: '{{ auid }}', auW: {{ width }}, auH:
  {{ height }}, container: '{{ invocation_method }}' }] })`. Values are Twig-autoescaped and, per the
  mechanism above, are constrained to admin-defined units and the fixed iframe/div list.
