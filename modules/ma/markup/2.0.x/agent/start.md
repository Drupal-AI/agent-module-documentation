# markup (Markup) — agent start

Defines a `markup` Field API field type (plus matching `markup` widget and `markup`
formatter) that outputs a **fixed** block of HTML/markup, defined once in the field's
**settings** (a `text_format`: value + format), on both the entity **edit form** (widget)
and the entity **display** (formatter). It is the Field UI equivalent of adding a
`#markup` element to `$form`. Depends only on core `field`. Package: *Field types*.
No admin settings page, no permissions, no Drush (`configure` is null); everything is
configured in the per-field settings form. Cardinality is forced to 1.

- Add a Markup field and set its markup/format; behavior & gotchas → [configure/markup.md](configure/markup.md)
- Field type/widget/formatter internals, storage quirk, hooks → [api/markup.md](api/markup.md)
