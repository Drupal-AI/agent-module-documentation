# Theming the button (`button_link`)

`button_formatter_theme()` (`hook_theme` in `button_formatter.module`) registers one theme hook:

```php
'button_link' => [
  'variables' => [
    'button' => NULL,       // a Drupal\Core\Link built by the formatter
    'description' => NULL,   // passed to the hook but not set by the formatter
    'entity' => NULL,        // the host entity ($items->getEntity())
    'field_name' => NULL,    // the field machine name
  ],
],
```

Default template `templates/button-link.html.twig` contains only:

```twig
{{ button }}
```

So the rendered output is whatever core's link generator produces for the `Link` object — an
`<a href="…" class="global_class style [external]" [download] [target=_blank]>…</a>`. The style
and global class come from config; the label/href come from the field value (see
[../fields/formatter.md](../fields/formatter.md)).

## Overriding the markup
Copy `button-link.html.twig` into your theme and use the available variables. `entity` and
`field_name` let you branch on context; `button` is the ready-to-print link. Example wrapping:

```twig
<span class="cta-wrapper">{{ button }}</span>
```
Clear caches (`drush cr`) after adding the override.
