<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming: `toc_js` theme hook, template, libraries

## Theme hook

`hook_theme()` registers `toc_js` with variables `title`, `tag`, `title_attributes`, `attributes`,
`entity`. Default template `templates/toc-js.html.twig`:

```twig
<div {{ attributes }}>
  <nav role="navigation"{% if title is not empty %} aria-labelledby="{{ title_attributes.id }}"{% endif %}>
    {% if title is not empty %}<{{ tag }} {{ title_attributes }}>{{ title }}</{{ tag }}>{% endif %}
  </nav>
</div>
```

The `<div>` gets class `toc-js` (plus configured classes) and the settings as `data-*` attributes;
the JS library populates the `<nav>` with the generated list on the client.

## Theme suggestions

`hook_theme_suggestions_toc_js_alter()` adds, when an entity is in context:

- `toc_js__<entity_type>`
- `toc_js__<entity_type>__<bundle>`
- `toc_js__<entity_type>__<bundle>__<id>`

So you can override the wrapper per entity type/bundle/id (e.g. `toc-js--node--article.html.twig`).

## Libraries

- `toc_js/toc` — `css/toc.css` + `js/toc_js.js`; depends on `core/jquery`, `core/drupal`,
  `core/once`, and `toc_js/tocjs`.
- `toc_js/tocjs` — `assets/js/tocjs.js` (the underlying TOC generator library).

`buildToc()` attaches `toc_js/toc`; you normally don't attach libraries yourself.
