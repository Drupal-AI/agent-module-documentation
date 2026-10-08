<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works: preprocess hook, classes, and the toggle library

The whole module is two hooks in `unpublished_paragraphs.module` plus one library
(`unpublished_paragraphs.libraries.yml`). No PHP classes, services, config, or permissions.

## The preprocess hook

`unpublished_paragraphs_preprocess_paragraph(&$variables)`:

1. Bails out on **admin routes** (`\Drupal::service('router.admin_context')->isAdminRoute()`),
   so edit screens are untouched.
2. For the current paragraph, if `$paragraph->isPublished()` is **FALSE**:
   - wraps `$variables['attributes']` in an `Attribute` object and adds classes
     `paragraph` and `unpublished`;
   - attaches the library: `$variables['#attached']['library'][] =
     'unpublished_paragraphs/unpublished-toggle';`.

So the classes and toggle only appear for paragraphs that are (a) unpublished and (b) actually
rendered on a non-admin page. The module does **not** control *whether* an unpublished paragraph
renders — that is core Paragraphs / entity access. If a user cannot view the unpublished
paragraph, it is never rendered and there is nothing to toggle.

## The library (`unpublished-toggle`)

`unpublished_paragraphs.libraries.yml` defines `unpublished-toggle` with:
- `unpublished-toggle.css` (component, footer scope, weight -200)
- `unpublished-toggle.js`
- dependencies: `core/drupal`, `core/jquery`, `core/once`.

### CSS (`unpublished-toggle.css`)

- `.unpublished-toggle` — a `position:fixed` dark button pinned bottom-right (the toggle).
- `.paragraph.unpublished` — `display:none` by default, with a pink (`#e91e63`) dotted border.
- `.paragraph.unpublished::after` — a pink "Unpublished" corner label.

### JS (`unpublished-toggle.js`)

`Drupal.behaviors.publishToggle`:
- If any `.paragraph.unpublished` exists in the context, appends
  `<div class="unpublished-toggle">Toggle visibility of unpublished items</div>` to `<body>`
  once (`once('unpublished-toggle', 'body')`).
- On `mousedown` of the toggle, runs `$('.paragraph.unpublished').toggle();` — showing/hiding
  every unpublished paragraph on the page.

## Restyling / overriding

There is nothing to configure. To change the look, override the CSS in your theme (target
`.unpublished-toggle` and `.paragraph.unpublished`), or provide your own library that replaces
`unpublished_paragraphs/unpublished-toggle` via `libraries-override` in the theme's `.info.yml`.
The button text comes from `Drupal.t('Toggle visibility of unpublished items')`, so it is
translatable via the interface translation UI.
