<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The 'Anchor' paragraph type (drowl_paragraphs_bs_type_anchor)

## Install & enable

```bash
drush en drowl_paragraphs_bs_type_anchor -y
```

Enabling pulls in its dependencies (`drowl_paragraphs_bs:drowl_paragraphs_bs`, `fences:fences`) and imports the shipped `config/install` (paragraphs_type, fields, entity form/view displays, optional language content settings). It has no permissions, routes, services or config schema of its own.

## Bundle(s) & fields

`field_anchor_id` (string, id attribute) and `field_anchor_title` (string, menu/scrollspy title; storage shipped here).

## Template

`templates/paragraph--drowl-paragraphs-bs--anchor.html.twig` extends the base `@drowl_paragraphs_bs/paragraph--drowl-paragraphs-bs.html.twig`. In `preview` view mode it defers to the parent template; otherwise it builds a Twig `create_attribute()` object and outputs:

```html
<div id="{anchor_id}" data-scrollspy="true" data-scrollspy-target="{anchor_id}" class="paragraph-anchor">
  <span class="hidden prevent-empty-detection">&nbsp;</span>
</div>
```

`data-anchor-menu-title` is added only when `field_anchor_title` is filled. All values are written through the Twig `Attribute` object.

## `.module`

Only `hook_theme()` registering the template. No preprocess, no UI Styles, no library.

## Notes

- This is a presentational bundle for the Paragraphs / Layout Paragraphs stack; it is not standalone.
- Per-instance options are UI Styles selected under the Paragraphs 'Settings', not a config form.
- Override the template in your Bootstrap 5 / Radix / DROWL Base theme to change markup.
