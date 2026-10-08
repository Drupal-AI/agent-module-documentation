<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EBT Countdown — block type, fields & displays

Everything ships as default config in `config/install/` (installed once at enable; edit the block
type / displays afterward through the UI, not the module).

## Install / enable

`drush en ebt_countdown` (requires `datetime`, `ebt_core`, `paragraphs`, and the
`levmyshkin/flipdown` library at `/libraries/flipdown`). EBT Core needs a Media "Image" type to
exist before install (used for background-image design options). No enable-time hooks in this
module; on this site enable can fail if the `ebt_core` field-storage dependency chain is absent.

## Block content type

- `block_content.type.ebt_countdown` — id `ebt_countdown`, label **EBT Countdown**, `revision: 0`.

## Fields (config/install)

- **`field_ebt_countdown_date`** — `datetime` field, `datetime_type: datetime`, **required**,
  cardinality 1. Storage: `field.storage.block_content.field_ebt_countdown_date`. This is the target
  date of the countdown.
- **`body`** — standard `text_with_summary` (from core config, `field.field...body`).
- **`field_ebt_settings`** — `ebt_settings` field type (defined by `ebt_core`), translatable,
  optional. Its `default_value` seeds EBT Core design options (margins/borders/padding, border color
  & style, border radius, background color/media/image style, edge-to-edge, container width) with
  `pass_options_to_javascript: false` by default — the countdown widget overrides that to TRUE (see
  [../fields/settings-widget.md](../fields/settings-widget.md)).

## Form display (`core.entity_form_display.block_content.ebt_countdown.default`)

- Uses `field_group` **tabs**: a *Content* tab (`body`, `field_ebt_countdown_date`) and a *Settings*
  tab (`field_ebt_settings`).
- `field_ebt_settings` uses widget **`ebt_settings_countdown`** (weight 4).
- `field_ebt_countdown_date` uses `datetime_default` widget. Depends on `field_group` and `text`
  modules for the form display config.

## View display (`core.entity_view_display.block_content.ebt_countdown.default`)

- `field_ebt_countdown_date` → `datetime_default` formatter (label above); `body` → `text_default`
  (label hidden); `field_ebt_settings` → `ebt_settings_default` formatter (from `ebt_core`).
- Note: the two Twig templates re-render the date into a `data-date` timestamp and hide the raw
  settings/date output; see the settings-widget doc.

## Placement

Create a custom block of type *EBT Countdown* at *Block layout » Add custom block*, then place it in
a region or via **Layout Builder** (inline blocks are supported — a separate template handles
`inline-block`). No configuration form/route is provided by this module.
