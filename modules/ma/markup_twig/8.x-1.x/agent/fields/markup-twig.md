<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Markup Twig widget & formatter

## Install & enable

```bash
composer require drupal/markup      # base dependency
composer require drupal/markup_twig
drush en markup_twig -y             # enables markup + field automatically
```

Dependencies: core `field` and the contrib **`markup`** module (`markup:markup`). Markup Twig has
no `composer.json` in the release and pulls nothing beyond those.

## The field type it targets

Markup Twig does **not** define a field type. The base **Markup** module defines the `markup` field
type. Its setting schema (`markup/config/schema/markup.schema.yml`) is:

```yaml
field.field_settings.markup:
  type: mapping
  mapping:
    markup:
      type: text_format      # -> { value: <text>, format: <text-format id> }
```

So a markup field stores **one text value + one text format in the field configuration** (the
Markup field is single-value; `markup_twig_form_field_storage_config_edit_form_alter()` removes the
cardinality selector to keep cardinality 1). There is **no per-entity value** — the widget only
displays the configured markup on the entity form.

## Enabling Twig rendering

Add a **Markup** field to a bundle, then set the **Markup Twig** plugin on either display:

- *Manage form display* (`admin/structure/types/manage/<bundle>/form-display`) → widget
  **"Markup Twig"** (`markup_twig`).
- *Manage display* (`admin/structure/types/manage/<bundle>/display`) → formatter
  **"Markup Twig"** (`markup_twig`).

With the plain **Markup** widget/formatter the configured text renders literally; with **Markup
Twig** it is rendered as a Twig template. Both plugins declare `field_types = { "markup" }`.

## Rendering mechanism

`MarkupTwigHelpers::buildElementInlineTemplate($value, $format, $langcode, $context)`
(`src/MarkupTwigHelpers.php`) returns:

```php
[
  '#type' => 'inline_template',        // core InlineTemplate render element
  '#template' => $value,               // the configured markup text
  '#context' => $context,              // assembled Twig variables (below)
  '#post_render' => [[self::class, 'applyTextFormatFiltersInPostRender']],
  '#markup_twig_format' => $format,
  '#markup_twig_langcode' => $langcode,
]
```

- Core's `inline_template` element (`preRenderInlineTemplate()`) calls
  `\Drupal::service('twig')->renderInline($template, $context)` — the Twig text is compiled and
  rendered with Drupal's Twig service.
- The `#post_render` callback `applyTextFormatFiltersInPostRender()` runs the rendered string
  through `check_markup($rendered, $format, $langcode)`, applying the field's selected text format
  **after** Twig has run. The class implements `TrustedCallbackInterface` and lists
  `applyTextFormatFiltersInPostRender` in `trustedCallbacks()` so core allows it as a `#post_render`
  callback.

Because the Twig text is **field configuration**, this is intended for administrators/site builders
who author templates as part of site configuration (see *Permission* below), not for content
authors.

## Twig context

`MarkupTwigHelpers::getTwigGlobalContext()` provides the shared variables, and each plugin adds a
few of its own.

Global (both widget and formatter):

| Variable | Source |
|---|---|
| `theme` / `theme_directory` | active theme name / path |
| `base_path` | `base_path()` |
| `base_root` | global `$base_url` |
| `is_front` | `path.matcher`->`isFrontPage()` |
| `language` | current language object |
| `is_admin` | current user has *access administration pages* |
| `logged_in` | current user is authenticated |
| `site_name` / `site_slogan` | `system.site` config (`strip_tags`-cleaned) |

Both plugins additionally set:

- `<entity_type>` — the entity being rendered, keyed by its type id (e.g. `node`, `user`, `term`),
  from `$items->getEntity()`.
- `field_name` — `$items->getName()`.

Formatter only (`MarkupTwigFormatter::viewElements()`): `formatter_field_langcode`,
`formatter_field_view_mode`, `formatter_field_label_position`.

Widget only (`MarkupTwigWidget::formElement()`): `widget_form` (the `$form` array),
`widget_form_state` (the `FormStateInterface`).

## Permission & form alters (`markup_twig.module`)

- Permission **`administer markup fields`** (`markup_twig.permissions.yml`) — declared with
  `restrict access: true`.
- `markup_twig_form_field_config_edit_form_alter()` — on any `markup` field's config edit form it
  appends usage notes to the field description, `unset($form['default_value'])` (so a broken
  template cannot make the field's own edit form unreachable), and, **if the current user lacks
  `administer markup fields`**, shows a warning message and sets `$form['settings']['markup']
  ['#disabled'] = TRUE`, so only holders of that permission can change the Twig text. (Reaching this
  form at all also requires Field UI admin access to the bundle, e.g. *administer node fields*.)
- `markup_twig_form_field_storage_config_edit_form_alter()` — removes the cardinality container for
  markup fields (forces single value).

## Operating notes

- Enable **Twig debug** to use `{{ dump() }}` / `{{ kint() }}` while authoring templates.
- Install **Twig Tweak** to get filters such as `|view` and `|image_style` used in the project's
  example snippets; base Markup Twig does not add its own filters/functions.
- Grant `administer markup fields` only to trusted administrators / site builders — the configured
  text is rendered as a Twig template on the site.
