<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraph type `ept_micromodal` and its fields

Everything here is defined as installed config under `config/install/`. Enabling the module creates
**one** Paragraphs bundle and its fields plus the default form/view displays. There is no PHP that
builds them and no config schema shipped by this module (the `ept_settings` field type's schema comes
from `ept_core`).

## Bundle `ept_micromodal`

`paragraphs.paragraphs_type.ept_micromodal` — label **"EPT Micromodal"**, description
"Extra Paragraph Type (EPT): Micromodal", no behavior plugins. This is the paragraph an editor adds
to content (via any Paragraphs / entity-reference-revisions field).

| Field name | Type | Storage / settings | Role |
|---|---|---|---|
| `field_ept_title` | `text_long` | shared storage from ept_core (`field.storage.paragraph.field_ept_title`), `allowed_formats: {}` | Optional page-level heading, printed **above** the trigger in a title wrapper by the template. |
| `field_ept_micromodal_title` | `text_long` | **ships in this module** (`field.storage.paragraph.field_ept_micromodal_title`, cardinality 1, **translatable**) | The modal's header title (`<h2 class="modal__title">`). |
| `field_ept_text` | `text_long` | shared storage from ept_core, `allowed_formats: {}` | The modal **body** content (`<main class="modal__content">`). |
| `field_ept_settings` | `ept_settings` | provided by ept_core | Per-paragraph settings — trigger/close text, trigger type, close-icon toggle, disable-scroll — plus the shared EPT design options. See [../configure/settings.md](../configure/settings.md). |

All three text fields are formatted-text (`text_long`) with an empty `allowed_formats`, i.e. the
editor picks any text format they have access to; output goes through the `text_default` formatter
(`check_markup`) at view time. This is standard privileged authoring — the same as the rest of the
EPT family.

## Form display

`core.entity_form_display.paragraph.ept_micromodal.default` uses **field_group** to split the edit
form into horizontal **Tabs** (`group_tabs`, `format_type: tabs`):

- **Content** tab (`group_content`, `formatter: open`): `field_ept_title` (weight 1),
  `field_ept_text` (weight 2), `field_ept_micromodal_title` (weight 3).
- **Settings** tab (`group_settings`, `formatter: closed`): `field_ept_settings` (weight 3).

Widgets: `field_ept_settings` → **`ept_settings_micromodal`** (this module's widget);
`field_ept_title` / `field_ept_text` / `field_ept_micromodal_title` → `text_textarea` (5 rows).
`created` and `status` are hidden.

## View display

`core.entity_view_display.paragraph.ept_micromodal.default`:

| Field | Formatter | Key settings |
|---|---|---|
| `field_ept_title` | `text_default` | label hidden, weight 2 |
| `field_ept_settings` | `ept_settings_default` (ept_core) | label hidden, weight 2 — emits the design `<style>` block and attaches the JS options (see [../theme/rendering.md](../theme/rendering.md)) |
| `field_ept_text` | `text_default` | label hidden, weight 3 |
| `field_ept_micromodal_title` | `text_default` | label hidden, weight 4 |

The template does not rely on view-display weights for placement — it pulls each field into a fixed
slot (title wrapper, trigger, modal header, modal body) and uses
`content|without('field_ept_settings', 'field_ept_text', 'field_ept_micromodal_title', 'field_ept_title')`
so the general `{{ content }}` print does not duplicate them.

## Reusing the bundle

The bundle and fields are created automatically on install (`drush en ept_micromodal`). To use the
modal in content, add a Paragraphs (or Entity Reference Revisions) field to a node/entity type and
allow the `ept_micromodal` bundle — no module-specific API is involved.
