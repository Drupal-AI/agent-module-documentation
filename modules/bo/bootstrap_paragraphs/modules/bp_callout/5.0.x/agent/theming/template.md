<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming the callout

## Theme hook

`bp_callout.module` → `hook_theme()`:

```php
'paragraph__bp_callout' => ['base hook' => 'paragraph']
```

Template: `templates/paragraph--bp-callout.html.twig`. Override it by copying that file into
your theme's `templates/` directory (same name) and clearing caches.

## Library

`bp_callout.libraries.yml`:

```yaml
bp-callout:
  css:
    component:
      css/bp-callout.min.css: { preprocess: false, minified: true }
```

Sources: `scss/bp-callout.scss` → `css/bp-callout.css` / `css/bp-callout.min.css`.
The template attaches **two** libraries: `bootstrap_paragraphs/bootstrap-paragraphs`
(from the parent module) and `bp_callout/bp-callout`.

## Markup it emits

```html
<div class="paragraph paragraph--type--bp-callout paragraph--view-mode--default
            {width class} {background classes} {callout-style class}"
     id="callout-{paragraph id}">
  <div class="paragraph__column">
    <div class="callout-header"><h2>{{ bp_header }}</h2></div>   {# only if bp_header set #}
    <div class="callout-body">
      {{ content|without('bp_background','bp_callout_style','bp_header','bp_width') }}
    </div>
  </div>
</div>
```

- The class list is built by matching the field's stored string against a hard-coded
  whitelist in Twig (`'callout-style--primary' == callout_style ? 'callout-style--primary'`,
  and likewise for all 5 width and 58 background values). **A value not in that whitelist
  produces no class**, so if you add an allowed value to the storage you must also add it to
  the template (or override the template with a pass-through).
- `id` is `'callout-' ~ paragraph.id.value`.
- `bp_callout_content` is *not* stripped by the `without()` filter, so nested paragraphs
  render inside `.callout-body`.

## Overriding styles from a theme

```yaml
# mytheme.info.yml
libraries-override:
  bp_callout/bp-callout:
    css:
      component:
        css/bp-callout.min.css: css/my-callout.css
```
