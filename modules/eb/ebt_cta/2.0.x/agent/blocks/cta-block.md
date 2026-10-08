<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ebt_cta` block content type

## Install & enable

```bash
composer require drupal/ebt_cta
drush en ebt_cta -y
drush cr
```

Pulls in `ebt_basic_button`, `ebt_core`, `paragraphs` and core `link`/`media`. `hook_requirements()`
in `ebt_cta.install` **blocks install** (severity error) unless a Media type with id `image`
exists — create one at `/admin/structure/media` first if missing. There is no settings route
(`configure` is null); everything is per-instance on the block edit form.

## The bundle

`config/install/block_content.type.ebt_cta.yml` defines block content type **`ebt_cta`**
("EBT Call to Action (CTA)"), `revision: 1`. Create instances at
**Structure → Block layout → Custom block library → Add custom block → EBT Call to Action (CTA)**,
then place the block in a region or add it inside a **Layout Builder** section (works as both
`block_content` and inline block — hence the two templates).

`hook_uninstall()` intentionally **does not delete** the block type or its content ("for
consistency reasons"); remove it manually if you want it gone.

## Fields (installed config)

| Field | Type | Required | Notes |
|---|---|---|---|
| `field_ebt_cta_title` | `text_long` (`text_textarea`) | no | Heading/lead text. |
| `body` | `text_with_summary` (`text_textarea_with_summary`) | no | Main copy; summary disabled. |
| `field_ebt_cta_column_image` | `entity_reference` → Media (`media_library_widget`) | no | Target bundle `image` only. |
| `field_ebt_cta_link` | `link` (`link_default`) | **yes** | Primary CTA button; `title: 1` (optional label — set by `update_9201`), `link_type: 17`. |
| `field_ebt_cta_second_link` | `link` (`link_default`) | no | Optional second button; `title: 2` (label required). |
| `field_ebt_settings` | `ebt_settings` (`ebt_settings_cta` widget) | no | Layout + button + design settings (see settings doc). |

All fields are cardinality 1. The `ebt_settings` field type and its default view formatter
(`ebt_settings_default`) come from **`ebt_core`**, not this module.

## Form display

`core.entity_form_display.block_content.ebt_cta.default.yml` groups the edit form into
**field_group tabs** (requires `field_group`): a *Content* tab (title, body, image, both links)
and a *Settings* tab (the `field_ebt_settings` widget, using `ebt_settings_cta`). The Settings tab
is collapsed by default.

## View display

`core.entity_view_display.block_content.ebt_cta.default.yml` renders image as `media_thumbnail`
(lazy loading), title/body as `text_default`, both links as core `link` formatter, and
`field_ebt_settings` with `ebt_settings_default`. The actual visible markup, however, is produced
by the module's **Twig templates**, which pull individual fields out of `content` and re-lay them
into `.column-1` / `.column-2` (two-column styles) or a single column, appending the buttons in a
`.cta-button-wrapper`. See [settings.md](../config/settings.md) for how styles drive the layout.
