<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling paragraph embedding on a text format

There is no global settings form. You enable embedding **per text format**, then editors use the
CKEditor 5 button. Two things must be on for a given format
(`/admin/config/content/formats/manage/<format>`):

1. **Filter** — enable **"Display embedded paragraphs"** (filter id `paragraphs_entity_embed`).
   It is a `TYPE_TRANSFORM_REVERSIBLE` filter that turns `<drupal-paragraph>` tags into rendered
   paragraphs on output.
2. **Toolbar button** — drag the **Paragraphs** button into the active CKEditor 5 toolbar
   (CKEditor 5 plugin `paragraphs_entity_embed_paragraphsEmbed`). The button is tied to the
   `paragraphs` embed button.

Order matters in the UI: enabling the plugin/button and the filter are independent settings on
the same format; the plugin's `conditions.filter` is `paragraphs_entity_embed`, so the button
only functions when the filter is enabled.

## Enable the filter in code

```php
$format = \Drupal\filter\Entity\FilterFormat::load('full_html');
$format->setFilterConfig('paragraphs_entity_embed', ['status' => TRUE]);
$format->save();
```

Check it:
```php
$format->filters('paragraphs_entity_embed')->status;   // TRUE when enabled
// or: drush cget filter.format.full_html filters.paragraphs_entity_embed.status
```

## Shipped config (config/install)

- `embed.button.paragraphs` — the embed button (`id: paragraphs`, `type_id:
  paragraphs_entity_embed`, empty `type_settings`, optional `icon_uuid`). Manage its embed-type
  settings at `/admin/config/content/embed`.
- `core.entity_view_mode.paragraph.embed` — the **Embed** view mode used to render embedded
  paragraphs.

## Embed type settings (`embed.embed_type_settings.paragraphs_entity_embed`)

On the embed button (embed type `Paragraph`):
- `enable_paragraph_type_filter` (bool) — restrict which paragraph bundles can be embedded.
- `paragraphs_type_filter` (sequence) — the allowed paragraph bundle machine names.
- `paragraphs_add_mode` (string) — `dropdown` | `button` | `select` (how the add UI lists types).

## Permissions

`view` / `add` / `edit` / `delete paragraphs entity embed` gate the corresponding operations on
`embedded_paragraphs` entities; `administer paragraphs entity embed` (restricted) covers admin.
Grant `add paragraphs entity embed` to roles that should be able to insert embeds.

## Edit form / field UI route

`entity.embedded_paragraphs.edit_form` at
`/admin/structure/paragraphs_entity_embed/{paragraphs_type}` (permission `administer paragraphs
entity embed`) is the `field_ui_base_route` for the embed entity.
