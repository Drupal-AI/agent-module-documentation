<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Landing Page content type, fields, displays, and role grants

All items below are shipped YAML. This is a config feature installed via the Drutopia distribution
(`composer require drupal/drutopia_landing_page` then enable, or install the distribution).
Enabling imports the config; no code runs. The type is marked **DEPRECATED** ("Use Page instead.").

## Node type — `config/install/node.type.landing_page.yml`

- `type: landing_page`, name **"Landing page (DEPRECATED)"**, description "Use Page instead.
  (Landing pages can be used for custom pages such as the home page.)"
- `new_revision: true`, `preview_mode: 1` (optional), `display_submitted: false`.
- `third_party_settings.menu_ui`: available menu **`main`**, parent `main:` (pages can be placed in
  the main menu).

## Fields (`config/install/field.field.node.landing_page.*.yml`)

Two configured fields on the `landing_page` bundle (their field storages come from
Paragraphs/Metatag, not shipped here):

| Field name | Label | Type | Notes |
|---|---|---|---|
| `field_body_paragraph` | Body paragraph | entity_reference_revisions | handler `default:paragraph`; target paragraph bundles **text, file, image, slide** (drag-drop weights; `update` bundle disabled). Not required, translatable. |
| `field_meta_tags` | Meta tags | metatag | default value `a:0:{}`; not required, translatable. |

The core `promote` field is overridden by
`config/install/core.base_field_override.node.landing_page.promote.yml` — label "Promoted to front
page", **default value `0`** (landing pages are not promoted to the front page by default).

## Form display — `core.entity_form_display.node.landing_page.default.yml`

Single `default` form display. Widgets: `title` (string_textfield), `field_body_paragraph`
(`entity_reference_paragraphs` widget — `edit_mode: open`, `add_mode: button`,
`default_paragraph_type: _none`), `field_meta_tags` (`metatag_firehose`), `uid`
(entity_reference_autocomplete), `created` (datetime_timestamp), `path`, `status`
(boolean_checkbox), `url_redirects`. **Hidden:** `promote`, `sticky`.

## View displays — `core.entity_view_display.node.landing_page.*.yml`

- **default:** empty `content`; **everything hidden** (`field_body_paragraph`, `field_meta_tags`,
  `links`, `search_api_excerpt`) — the default view mode renders no fields.
- **full:** uses **Display Suite** (`ds`) layout **`ds_1col`**; renders `field_body_paragraph`
  (label hidden) in the `ds_content` region via formatter
  `entity_reference_revisions_entity_view` (paragraphs rendered in their own `default` view mode).
  `field_meta_tags`, `links`, `search_api_excerpt` hidden. This is the display used for the full
  page.
- **teaser:** `status: false` (**disabled**); all fields hidden.

All formatters are standard core/contrib display formatters (paragraph entity view, metatag). No
field renders raw user- or remote-supplied markup.

## URL alias — `pathauto.pattern.node_landing_page.yml`

`id: node_landing_page`, type `canonical_entities:node`, pattern **`[node:title]`**, restricted to
bundle `landing_page` (selection `entity_bundle:node`), weight `-5`. Aliases are generated straight
from the title (no path prefix).

## Exclude node title — `config/actions/exclude_node_title.settings.yml`

A Drutopia config action against `exclude_node_title.settings`: removes the legacy global `type`
value, sets `content_types.landing_page` to **`user`** (title exclusion is selectable per node),
and sets `content_type_modes.landing_page` to **`['full']`** — i.e. the node title can be excluded
on landing pages in the **full** view mode.

## Role permission grants — `config/actions/user.role.editor.yml`, `user.role.manager.yml`

These use the Drutopia config-actions mechanism: each file `add`s a `node.type.landing_page` config
dependency and `add`s permission strings to the existing role's `permissions` list (it modifies
Drutopia roles rather than defining new ones). There is **no contributor grant** for this type.
Grants are landing-page-scoped only — **no delete, admin, bypass, or other privileged permission**:

| Role | Permissions granted |
|---|---|
| `editor` | `create landing_page content`, `edit any landing_page content` |
| `manager` | `create landing_page content`, `edit any landing_page content` |

Both roles receive the identical two standard per-bundle node permissions. Delete and all other
access remain governed by core node permissions and the site's role configuration.
