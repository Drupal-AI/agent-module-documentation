<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ept_text — template, classes and inline styles

The module ships one template: **`templates/paragraph--ept-text--default.html.twig`**.

## What it renders

```twig
<div{{ attributes.addClass(classes) }}>
  <div class="bg-inner"></div>
  <div class="ept-container">
    {% if content.field_ept_title|render %}
      <h2>{{ content.field_ept_title }}</h2>
    {% endif %}
    {{ content|without('field_ept_settings', 'field_ept_title') }}
  </div>
</div>
{{ styles|raw }}
```

- Wraps the paragraph in `.ept-container`, with an empty `.bg-inner` div used for background
  image/video effects.
- Prints the **title** in an `<h2>` only when it has content; prints the rest of the content
  (chiefly the WYSIWYG body `field_ept_text`) via `content|without(...)`, excluding the title and the
  settings field. Both title and body come through the `text_default` formatter, i.e. filtered by the
  editor's text format.
- `classes` set on the wrapper: `paragraph`, `paragraph--type--ept-text`,
  `ept-paragraph--type--ept-text`, `paragraph--view-mode--<mode>`, `paragraph--unpublished` (when
  unpublished), `ept-paragraph`, and `paragraph-id-<id>`.

## Where `styles` comes from

`styles` is **not** set by this module. `ept_core`'s `hook_preprocess_paragraph`
(`Drupal\ept_core\Hook\EptCoreHooks::preprocessParagraph`) runs for any `ept_*` bundle, reads
`field_ept_settings[0]['ept_settings']['design_options']`, and calls the `ept_core.generate_css` service
(`GenerateCSS::generateFromSettings($design_options, 'paragraph-id-' . $id)`). That returns a literal
`<style>.paragraph-id-<id>{ … } … </style>` string scoped to this paragraph's id class, which the
template emits with `{{ styles|raw }}`. The same hook also attaches `ept_core` libraries and
`drupalSettings.eptCore` breakpoints, and (for backgrounds) the parallax / video-player JS.

## Overriding

To restyle, **override the template in your theme** (copy
`paragraph--ept-text--default.html.twig` into your theme's `templates/`) rather than editing the module.
The theme hooks and paragraph theme suggestions for `ept_*` bundles are registered by `ept_core`
(`theme_registry_alter` / `theme_suggestions_paragraph_alter`). Site-wide look-and-feel defaults
(colors, breakpoints, container widths) are better changed on the EPT Core settings form — see
[../configure/paragraph-type.md](../configure/paragraph-type.md).
