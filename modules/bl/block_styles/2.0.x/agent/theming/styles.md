<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Registering your own block style

Block Styles offers, in the block form, any **Styles API** style whose `type` is `block`. You register
a style by shipping a `<extension>.themes.yml` file (in a module or theme) plus a Twig template — no
PHP required.

## The `*.themes.yml` entry

```yaml
block__myfeature__promo:          # the style id (also the theme suggestion) — convention: block__<name>
  label: 'Promo Wrapper'          # shown in the block-form select
  type: block                     # REQUIRED so Block Styles lists it
  category: Block
  configuration:
    path: templates/promo         # dir (relative to the providing extension) holding the template
    base hook: block              # extend the core 'block' theme hook
    render element: elements
  extras:                         # optional
    label: 1                      # if set, the block form enables the "button label" text field
    placement: 1
```

- The **style id** doubles as the theme suggestion. `block__myfeature__promo` →
  Drupal will look for `block--myfeature--promo.html.twig` (double underscores in the id map to
  double hyphens in the template filename).
- `type: block` is what makes Block Styles show the style; other `type` values are ignored by it.
- `configuration.path` points at the directory containing your Twig template; `base hook: block`
  and `render element: elements` register it as a `block` template variant.
- `extras.label` (truthy) turns on the **Text for button label** field in the block form (used by the
  interactive Bootstrap styles); omit it for purely presentational wrappers.

## The template

Create the template in the declared `path`, named after the suggestion:

```
templates/promo/block--myfeature--promo.html.twig
```

Start from core's `block.html.twig` (or the module's `templates/clean/block--clean.html.twig`) and
customise the wrapper markup. Available variables are the standard block template variables plus
`configuration.button_text` (set by `block_styles_preprocess_block()` from the style's `text`).

## Attach CSS/JS (optional)

Declare a library in your extension's `*.libraries.yml` and attach it from the template
(`{{ attach_library('mymodule/my_style') }}`) — this is how **Block Styles Bootstrap** ships CSS/JS
for its collapse, dropdown and modal styles.

## Provider scope

If the `*.themes.yml` lives in a **theme**, the style only applies while that theme is active (Block
Styles skips theme-provided styles under other themes). Put it in a **module** to apply site-wide.

See the bundled `block__clean` (module `block_styles`) and the five `block__bootstrap__*` styles
(submodule `block_styles_bootstrap`) as working examples.
