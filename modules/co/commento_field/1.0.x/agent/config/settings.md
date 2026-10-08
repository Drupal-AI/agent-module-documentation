<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field type, widget, formatter & render element

## Install / enable

`drush en commento_field`. No dependencies to pull in. Then:

1. **Structure → Content types → *(type)* → Manage fields** — add a field of type **Commento**.
2. **Manage display** — the **Commento** formatter shows the thread; open its settings gear for the
   display options below.
3. **People → Permissions** — grant `view commento comments` (see threads) and
   `toggle commento comments` (edit the per-entity on/off checkbox).

There is no site-wide settings form and no place to set a Commento server URL — the loader script
is fixed to `https://cdn.commento.io/js/commento.js`.

## Field type `commento` (`CommentoItem`)

- Storage: one column `status` — `int`, `not null`, default `1`. `mainPropertyName()` → `status`.
- `propertyDefinitions()`: integer property `status` ("Commento status").
- `isEmpty()` returns TRUE only when the value is the empty string `''` (so a stored 0 or 1 is
  never "empty").

## Widget `commento` (`CommentoWidget`)

- `formElement()` renders one checkbox `status`, title "Commento Comments", default value
  `$items->status` if set else TRUE.
- `#access => currentUser->hasPermission('toggle commento comments')` — users without that
  permission cannot see or change the toggle (the stored default 1 stands).
- No `defaultSettings()` / `settingsForm()` — the widget has no configurable settings.

## Formatter `commento` (`CommentoFormatter`) — display settings

`defaultSettings()` and `settingsForm()` (on **Manage display**) expose four display-mode settings:

| setting | form type | default | effect |
|---------|-----------|---------|--------|
| `css_override` | url | `''` | Described as "URL to a CSS file with overriding styles." **Collected but not applied** — see note. |
| `disable_auto_init` | checkbox | FALSE | Passed to the script as `data-auto-init` (negated). |
| `disable_default_font` | checkbox | FALSE | Passed as `data-no-fonts`. |
| `hide_deleted_comments` | checkbox | FALSE | Passed as `data-hide-deleted`. |

`viewElements()`:
- If the item list is empty, it falls back to the field's default value's `status` (so existing
  entities created before the field existed still get a value).
- Returns nothing unless `status` is truthy **and** the viewer has `view commento comments`.
- Otherwise builds `['#type' => 'commento', '#url' => <entity canonical URL>, '#css_override' => …,
  '#disable_auto_init' => (bool), '#disable_default_font' => (bool),
  '#hide_deleted_comments' => (bool)]`.

## Render element `commento` (`Element/Commento`)

`@RenderElement("commento")`. `getInfo()` defaults: `#title`, `#url`, `#identifier`, `#callbacks`
empty, `#attributes => ['id' => 'commento_thread']`, pre_render `generatePlaceholder`.

`generatePlaceholder()`:
- Re-checks `view commento comments`; returns the element unchanged (empty) if the viewer lacks it.
- Adds `script` (`#type => html_tag`, `<script>`) with attributes:
  `src => https://cdn.commento.io/js/commento.js` (**hardcoded**), `defer => TRUE`,
  `data-auto-init => var_export(!$disable_auto_init)`, `data-no-fonts => var_export($disable_default_font)`,
  `data-hide-deleted => var_export($hide_deleted_comments)`, `data-page-id => $element['#url']`
  (the entity canonical URL).
- Adds `container` (`<div id="commento">`) — Commento's mount point — and `noscript`
  ("Please enable JavaScript to load the comments.").

The `#css_override` value flows into the render element but `generatePlaceholder()` never reads it,
so **the CSS override URL setting currently has no effect** (dead/incomplete config).

## Permissions (`.permissions.yml`)

- `toggle commento comments` — gates the widget checkbox `#access`.
- `view commento comments` — gates both `CommentoFormatter::viewElements()` and the render
  element's `generatePlaceholder()`; without it, no script/markup is emitted.

## Config-schema note

`.schema.yml` declares `field.widget.settings.commento` (keys `disable_auto_init`,
`disable_default_font`, `hide_deleted_comments`, `css_override`). But those settings actually live
on the **formatter**, not the widget (the widget has no settings). There is no
`field.formatter.settings.commento` schema. So the declared schema targets the wrong plugin and the
formatter's real settings are unschemaed — a mismatch, not a runtime break.
