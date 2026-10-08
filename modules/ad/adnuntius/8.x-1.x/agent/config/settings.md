<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Adnuntius — settings, plugins, service, theming

Everything the module provides. Source under
`web/modules/contrib/adnuntius/`.

## Install / enable

`drush en adnuntius`. Dependencies: core **`block`** and **`field`** (`adnuntius.info.yml`). No
`.install`, no update hooks, no default config shipped — the ad-unit catalog starts empty.

## Permissions (`adnuntius.permissions.yml`)

- **`administer adnuntius`** — access the settings form (define/edit ad units). Not marked
  `restrict access`, but it only grants access to config the admin controls.
- **`use adnuntius field`** — gates the field widget's `auid` and `invocation_method` inputs
  (`AdnuntiusWidget::formElement()` sets `#access => currentUser->hasPermission('use adnuntius field')`
  on both).

## Route (`adnuntius.routing.yml`)

- `adnuntius.settings` → path `/admin/config/services/adnuntius`, `_form`
  `AdnuntiusSettingsForm`, `_permission: administer adnuntius`. Menu link
  `adnuntius.settings` under `system.admin_config_services` (`adnuntius.links.menu.yml`). This is
  the module's **only** route — no controllers, no `_access: TRUE`, no anonymous endpoints, no
  callbacks.

## Config object `adnuntius.settings` (schema `config/schema/adnuntius.schema.yml`)

- `ad_units`: sequence keyed by `auId`, each a mapping:
  - `label` (string) — human name.
  - `auid` (string) — the Adnuntius ad-unit id.
  - `width` (integer), `height` (integer) — default pixel size.
  - `weight` (integer) — sort order.

Also in schema: `block.settings.adnuntius_block` (`auid`, `invocation_method`),
`field.value.adnuntius` (`auid`, `invocation_method`), `field.field_settings.adnuntius`
(`invocation_method_per_entity` bool), `field.widget.settings.adnuntius` (`enabled_ad_units`,
`invocation_methods` sequences), `field.formatter.settings.adnuntius` (`invocation_method`).

## Settings form — `AdnuntiusSettingsForm` (`src/Form/…`)

`ConfigFormBase`, editable config `adnuntius.settings`, form id `adnuntius_settings`.
`buildForm()` renders a `#type => table` (tabledrag by weight) of ad-unit rows plus one empty `new`
row; each row (`buildRow()`) has `label`, `auid`, `width` (number), `height` (number), `weight`.
`submitForm()` drops rows with an empty `auid` (`array_filter`), re-keys the `new` row by its
`auid`, and saves. Deleting a row = clearing its values.

## Manager service — `AdnuntiusManager` (`src/AdnuntiusManager.php`), id `adnuntius.manager`

Implements `AdnuntiusManagerInterface`. Args `@config.factory`, `@renderer`.

- `getAdUnits()` → `adnuntius.settings.ad_units` (array|null).
- `getAdUnit($auId)` → the entry for `$auId`, or NULL if not configured.
- `getAdUnitsOptionList()` → `[auid => "label (WxH)"]` for select widgets.
- `getInvocationMethodOptionList()` → fixed `['iframe' => 'Iframe', 'div' => 'Div']`.
- `render($auId, $invocation_method)` → returns `[]` unless `getAdUnit($auId)` matches; otherwise a
  `#theme => 'adnuntius'` array with `#label/#auid/#width/#height` taken from the **stored** unit and
  `#invocation_method` from the argument. Adds `adnuntius.settings` as a cacheable dependency.

## Block plugin — `AdnuntiusBlock` (id `adnuntius_block`)

`build()` reads config `auid` + `invocation_method`, renders via the manager (only if the unit
exists). `blockForm()`: `auid` = **select** of `getAdUnitsOptionList()` (required),
`invocation_method` = select of iframe/div (default `div`, required). `blockSubmit()` saves both
config values.

## Field — type / widget / formatter

- **`AdnuntiusItem`** (`FieldType`, id `adnuntius`) — two varchar(255) columns `auid`,
  `invocation_method`; property defs of the same; field setting `invocation_method_per_entity`
  (default FALSE); `isEmpty()` true when both are empty.
- **`AdnuntiusWidget`** (`FieldWidget`, id `adnuntius`) — `formElement()` shows `auid` as a select of
  the configured units (falls back to a textfield when none configured), optionally filtered by the
  per-field `enabled_ad_units` whitelist. When `invocation_method_per_entity` is on, adds an
  `invocation_method` select filtered by the per-field `invocation_methods` whitelist. Both inputs
  are `#access`-gated on `use adnuntius field`. `settingsForm()` exposes the two whitelists;
  `massageFormValues()` unsets empty `auid`/`invocation_method`.
- **`AdnuntiusFormatter`** (`FieldFormatter`, id `adnuntius`) — setting `invocation_method` (default
  `iframe`). `viewElements()` renders each item through the manager; the item's own
  `invocation_method` overrides the formatter default only when `invocation_method_per_entity` is on
  and the value is non-empty. Renders nothing for an `auid` that is not a configured unit.

## Theming — `hook_theme` + `templates/adnuntius.html.twig`

`adnuntius_theme()` registers theme hook `adnuntius` with variables `label`, `auid`, `width`,
`height`, `invocation_method`. `adnuntius_theme_suggestions_adnuntius()` adds suggestions
`adnuntius__<invocation_method>` and `adnuntius__<auid>` for per-method / per-unit template
overrides. The default template outputs a hidden `<div id="adn-{{ auid }}">` and an inline
`<script>` that lazy-loads `//cdn.adnuntius.com/adn.js` and calls `adn.request(...)` with the unit's
`auId`, width, height and container mode. No server-side request is made by Drupal.

## Programmatic use

```php
$build = \Drupal::service('adnuntius.manager')->render('my-au-id', 'div');
```
Returns an empty array if `my-au-id` is not a configured ad unit.
