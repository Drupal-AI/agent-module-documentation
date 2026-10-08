<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ept_text — the paragraph type, its fields and displays

Enabling `ept_text` creates a **Paragraphs type** and the field/display config to use it. There is no
settings page of its own (`configure: null`); the only site-wide configuration is the shared **EPT Core**
form.

## The bundle

- Paragraphs type: `ept_text` (config `paragraphs.paragraphs_type.ept_text`), label **"EPT Text"**,
  description "Extra Paragraph Type (EPT) Text", no behavior plugins.
- Use it like any Paragraphs type: add a **Paragraphs (Revisions)** field to a content type (or other
  entity) and allow **EPT Text** as one of its bundles, then editors add an "EPT Text" paragraph inside
  that entity. Confirmed fields on the bundle at runtime: `field_ept_title`, `field_ept_text`,
  `field_ept_settings`.

## Fields

- **`field_ept_title`** — `text_long`, label "Title", not required, `allowed_formats: {}` (any format).
  Storage `field.storage.paragraph.field_ept_title` (owned by `ept_core`).
- **`field_ept_text`** — `text_long`, label "Text", not required, `allowed_formats: {}`. The WYSIWYG
  body. Storage `field.storage.paragraph.field_ept_text` (owned by `ept_core`).
- **`field_ept_settings`** — type `ept_settings` (field type, widget and formatter all owned by
  `ept_core`), label "Settings". Holds the per-paragraph design options.

## Form display (`paragraph.ept_text.default`)

Uses **Field Group** tabs (`group_tabs`):
- Tab **"Content"** (`group_content`, open): `field_ept_title` then `field_ept_text`, both with the
  `text_textarea` widget (rows 5).
- Tab **"Settings"** (`group_settings`, closed, region hidden by default): `field_ept_settings` with the
  `ept_settings_default` widget (from `ept_core`).
- `created` and `status` are hidden. Requires modules `ept_core`, `field_group`, `text`.

## View display (`paragraph.ept_text.default`)

- `field_ept_title` and `field_ept_text` → `text_default` formatter, labels hidden. Output goes through
  `check_markup()` with the editor's chosen text format, so allowed HTML follows your site's text-format
  and role policy.
- `field_ept_settings` → `ept_settings_default` formatter (from `ept_core`) — it produces no visible
  field markup; it is what feeds the design options into the inline styles (see
  [../theming/template.md](../theming/template.md)).

## Design options (from `ept_core`'s `ept_settings_default` widget)

Set per paragraph on the **Settings** tab; they drive the inline `<style>` block on output:
- **Box:** margin, padding, border width — top/right/bottom/left (validated numeric).
- **Border:** color (hex, validated), style, radius.
- **Background:** background color (hex), background image via a **Media "image"** entity with a style
  (cover / contain / repeat / parallax) and optional overlay color+opacity, or a background video
  (YouTube / local) with its own options; plus custom background-position and background-size fields.
- **Layout:** edge-to-edge (full-viewport width) and container max-width (xxsmall … xxlarge, or auto).

## Site-wide EPT Core settings

`ept_core` provides a settings form at **Administration » Configuration » Content authoring » Extra Block
Types (EPT) settings** (config `ept_core.settings`): primary/secondary colors, mobile/tablet/desktop
breakpoints, and the numeric widths that back the container-width option set. These apply as defaults
across all EPT paragraph types, including this one.
