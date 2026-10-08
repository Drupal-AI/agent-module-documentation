<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming the updated date

`updated_theme()` registers one theme hook:

```php
'field__node__changed__updated' => ['base hook' => 'field']
```

It is a `field`-based override used only for the block's rendered `changed` field. The shipped
template `templates/field--node--changed--updated.html.twig` is minimal — it wraps the field
items in a single `<span{{ attributes }}>…</span>`:

```twig
<span{{attributes}}>
  {%- for item in items -%}{{ item.content }}{%- endfor -%}
</span>
```

In the block build, the rendered field array is given `#theme = 'field__node__changed__updated'`
and a class `updated-date`; the prefix is a separate `<span class="updated-date-message">`.

To restyle the output, override `field--node--changed--updated.html.twig` in your theme, or
target the CSS classes `.updated-date-message` (prefix) and `.updated-date` (the date). No
other theme hooks, libraries, or render elements are provided.
