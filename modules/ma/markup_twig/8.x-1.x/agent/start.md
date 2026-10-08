<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Markup Twig (markup_twig) — agent index

Extends the contrib **Markup** field so a markup field's configured text is rendered as a **Twig
template** instead of static HTML. Package **Field types**. Version **8.x-1.0-rc7**, doc dir
**8.x-1.x**. Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.

## Dependencies

- `drupal:field` (core Field API).
- `markup:markup` — the contrib **Markup** module, which defines the `markup` field type and its
  base widget/formatter. Markup Twig subclasses both.

## What it provides

- **Field formatter** `markup_twig` (label *"Markup Twig"*, `field_types = { "markup" }`) —
  `src/Plugin/Field/FieldFormatter/MarkupTwigFormatter.php`, extends `markup`'s `MarkupFormatter`.
- **Field widget** `markup_twig` (label *"Markup Twig"*, `field_types = { "markup" }`) —
  `src/Plugin/Field/FieldWidget/MarkupTwigWidget.php`, extends `markup`'s `MarkupWidget`.
- **Helper class** `Drupal\markup_twig\MarkupTwigHelpers` (`src/MarkupTwigHelpers.php`,
  implements `TrustedCallbackInterface`) — builds the `inline_template` render array and assembles
  the Twig context.
- **Permission** `administer markup fields` (`markup_twig.permissions.yml`, `restrict access: true`)
  — required to edit the Twig text on the field settings form.
- Two `hook_form_FORM_ID_alter()` implementations in `markup_twig.module`.

No routes, no services, no config schema of its own (the field setting uses the base Markup
module's `field.field_settings.markup` schema), no Drush commands, no submodules.

## How it works (one paragraph)

Both the widget and the formatter read `$this->fieldDefinition->getSetting('markup')['value']`
(and `['format']`) — the text stored in the **field configuration** — and pass it to
`MarkupTwigHelpers::buildElementInlineTemplate()`, which returns a `#type => 'inline_template'`
render element (`#template` = the configured text, `#context` = the assembled Twig variables) plus
a `#post_render` callback that runs the rendered output through `check_markup()` with the field's
selected text format. The Twig text is **field configuration**, not per-entity content — editing it
requires the `administer markup fields` permission and Field UI access, so it is authored by
trusted administrators / site builders. Selecting the plain **Markup** widget/formatter instead
renders the same text literally.

## Solution docs

- **The widget, the formatter, the Twig context, the permission, and the form alters** →
  [fields/markup-twig.md](fields/markup-twig.md)
