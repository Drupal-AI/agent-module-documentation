<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ebt_hero — block type, fields, displays, install

## Install / enable

- `drush en ebt_hero` (pulls ebt_core, ebt_basic_button, paragraphs, link, media via composer/info deps).
- **Pre-req enforced in code:** `ebt_hero_requirements($phase='install')` (`ebt_hero.install`) loads
  all `MediaType`s and, if Media is enabled but no `image` type exists, returns an **error** severity
  requirement ("Media type Image / Not created") that stops install. Create a Media type with id
  `image` first (`/admin/structure/media`). If Media is not enabled at all, the check is skipped.
- No `hook_install`/`hook_uninstall`; the bundle + fields are pure `config/install` YAML.

## The block type

- `block_content.type.ebt_hero` (`config/install/block_content.type.ebt_hero.yml`): id `ebt_hero`,
  label "EBT Hero", `revision: 1`. It is a reusable custom block type; place instances via block
  library or Layout Builder (including inline blocks).

## Fields (all on bundle `ebt_hero`)

| Field | Type | Storage / target | Notes |
|-------|------|------------------|-------|
| `field_ebt_hero_title` | `text_long` | text | Main headline |
| `field_ebt_hero_title_prefix` | `text_long` | text | Kicker/subtitle above title |
| `body` | `text_with_summary` | text | `display_summary: false` |
| `field_ebt_hero_column_image` | `entity_reference` | target_type media, `target_bundles: {image}`, cardinality 1 | The hero image column |
| `field_ebt_hero_link` | `link` | link | Primary button |
| `field_ebt_hero_second_link` | `link` | link | Secondary button |
| `field_ebt_settings` | `ebt_settings` | provided by **ebt_core** | Holds all design/layout settings |

The `field_ebt_hero_column_image` field config **depends on `media.type.image`** — this is the config
object named in the install error; it is why the `image` media type must pre-exist.

## Form display (`core.entity_form_display.block_content.ebt_hero.default`)

- Uses **`field_group`** (a dependency of the form display) to build a `tabs` group with two tabs:
  - **Content** (`group_content`): title, title_prefix, body, column_image
    (`media_library_widget`), and the two link fields (`link_default`).
  - **Settings** (`group_settings`, collapsed): `field_ebt_settings` edited by widget
    **`ebt_settings_hero`**.
- Requires modules `ebt_hero`, `field_group`, `link`, `media_library`, `text`.

## View display (`core.entity_view_display.block_content.ebt_hero.default`)

- `field_ebt_hero_column_image` → `media_thumbnail`, label hidden, `image_loading.attribute: lazy`.
- `body`, `field_ebt_hero_title`, `field_ebt_hero_title_prefix` → `text_default` (labels hidden).
- Links → `link` formatter; `field_ebt_settings` → `ebt_settings_default` formatter (from ebt_core).
- Field weights drive default order; the Twig templates ultimately control layout, not weights.

## Relationship to EBT Core

- `field_ebt_settings` (the `ebt_settings` field type) and the shared design options (CSS box,
  background color/image/video, container width) come from **ebt_core**. Global defaults — primary/
  secondary colors and mobile/tablet/desktop breakpoints — live in `ebt_core.settings` at
  *Administration » Configuration » Content authoring » Extra Block Types (EBT) settings*. ebt_hero
  reads `ebt_core.settings` (e.g. `ebt_core_mobile_breakpoint`) as the fallback breakpoint.
- If the **Field Layout** module is on, disable Layout Builder for this bundle's display at
  `/admin/structure/block/block-content/manage/ebt_hero/display/default` (per README).
