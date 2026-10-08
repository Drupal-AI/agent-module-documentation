# Configure Display Suite

## Where
- **Admin → Structure → Display Suite** (`/admin/structure/ds`, route `ds.structure`) — overview of entity displays.
- **Manage display** tab of any entity/bundle — pick a DS layout in the "Layout for … in default" vertical tab, then drag fields into its regions.
- Global settings: `/admin/structure/ds/settings` (route `ds.admin_settings`, form `SettingsForm`, config `ds.settings`).
- Custom fields: `/admin/structure/ds/fields` (route `ds.fields_list`) — add token, twig, block, copy, or code fields.
- Region CSS classes: `/admin/structure/ds/classes` (route `ds.classes`).
- Emergency reset (disable all DS layouts if a layout breaks a display): `/admin/structure/ds/emergency` (route `ds.admin_emergency`).

## Layouts
Layouts ship in `ds.layouts.yml` as core Layout API plugins (class `\Drupal\ds\Plugin\DsLayout`):
`ds_1col`, `ds_1col_wrapper`, `ds_2col`, `ds_2col_fluid`, `ds_2col_stacked`, `ds_2col_stacked_fluid`,
`ds_3col`, `ds_3col_equal_width`, `ds_3col_stacked`, `ds_3col_stacked_equal_width`,
`ds_3col_stacked_fluid`, `ds_4col`, `ds_reset`. Each defines regions (e.g. `left`/`right`,
`header`/`left`/`right`/`footer`). Any custom Layout API layout also appears in the list.

## Custom (virtual) fields
Added from the fields UI and then placed on displays like real fields:
- **Token field** — arbitrary markup built from tokens (`ds.add_token_field`).
- **Twig field** — inline Twig template with entity variables (`ds.add_twig_field`).
- **Block field** — render a block plugin inside the display (`ds.add_block_field`).
- **Copy field** — duplicate another field's output into a second region (`ds.add_copy_field`).

## Config storage
Displays are stored on core `entity_view_display` config via DS third-party settings; global
options live in `ds.settings`. Schema in `config/schema/ds.*.schema.yml`. All exportable with
`drush config:export`, so displays deploy between environments.
