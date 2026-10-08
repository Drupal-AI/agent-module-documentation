<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Enhanced Image Formatter

## How it activates
The module does not add a new formatter option — it **replaces the core `image` formatter** globally via `hook_field_formatter_info_alter()`. On install it sets its module weight to 1 so its alter runs after `svg_image`'s (inheriting SVG rendering). So any image field using the "Image" formatter gets the enhanced behaviour once the module is enabled.

## Per-display settings (Manage display)
On an image field's formatter settings you get, in addition to the standard/SVG options:

### Tokenized ALT and TITLE
- **Alternative text** (`tokenizer.alt_text`) — supports tokens; up to 255 chars.
- **Title text** (`tokenizer.title_text`) — supports tokens; up to 255 chars.
- A token tree link is shown; token types are the host entity type (`taxonomy_term` is mapped to `term`).

At render, each string is token-replaced with the host entity as context (`clear => TRUE` removes unreplaced tokens), passed through `Xss::filter()`, and set on `#item_attributes['alt']` / `['title']`.

### Image link
The `image_link` option is extended with the entity's **link fields**: besides "content" and "file", you can link the image to the URL stored in any link field on the same entity/bundle. At render, `#url` is set from `entity->{field}->get(0)->getUrl()`.

## Notes
- Because the core `image` formatter id is reused, the change is site-wide for image fields — verify existing displays after enabling.
- ALT/TITLE come from admin-entered token templates and are sanitised; they render as escaped attributes.
