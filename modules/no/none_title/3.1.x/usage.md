<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
None Title suppresses a node's title from display when an editor types the literal string `<none>` into the title field. There is no configuration, no permission and no form change — the title field stays required, and the sentinel value is stored on the node.

---

The mechanism is deliberately small. The editor still fills in the required title field, but types the exact string `<none>` (surrounding whitespace is trimmed and ignored). The module then intercepts display in two places. `none_title_preprocess_field()` runs on every rendered field; when the field is `title` and the object is a node whose trimmed value equals `<none>`, it rewrites the rendered value to an empty string — so the `<h1>` on the node page renders blank. `none_title_views_plugins_field_alter()` swaps the default Views `field` handler class for `Drupal\none_title\Plugin\views\field\EntityField`, whose `getItems()` drops any `title` item whose raw value is `<none>` — so the row's title cell (for example on `admin/content`, which is a View) comes out empty. That is the whole module: no config form, no schema, no submit handler, no auto-generation, no token pattern. The value `<none>` is real stored data, so it still surfaces anywhere the entity **label** is read directly rather than rendered through the title field or a Views field handler: the HTML `<title>` element and Open Graph title, breadcrumbs and menu links, entity-reference autocomplete and rendered reference labels, and the search index. Version **3.1.0** on `^9.1 || ^10 || ^11`, depending only on core `node`. Note that the Views alter replaces the *global* field-handler class for all fields, so it can collide with another module that overrides the same `field` plugin. Because the module only ever blanks a title (it never emits new markup) it introduces no injection surface; the value is core-escaped like any title.

---

- Hide a node title on a landing page whose hero already carries the headline.
- Suppress a heading per node without a theme override.
- Blank the title on a homepage or campaign node.
- Use a node as a layout/paragraphs container with no visible title.
- Hide a title that duplicates text placed elsewhere on the page.
- Give editors per-node control over whether the title shows.
- Hide the `<h1>` on a design-led marketing page.
- Keep the title empty on `admin/content` and other Views listings (handled by the Views override).
- Avoid adding a "display title" boolean field to a content type.
- Hide titles on selected pages only, leaving the rest untouched.
- Suppress a repeated heading above a body field.
- Build a container node referenced by other content, with no heading.
- Hide a title on a node embedded in a Layout Builder region.
- Keep a title hidden in Views field output as well as on the node page.
- Give a single node a different title treatment from its bundle default.
- Suppress a heading on a print/PDF-style node view.
- Hide a title without writing a preprocess hook of your own.
- Blank a title on a node used purely for its rendered fields.
- Provide editors a simple sentinel (`<none>`) instead of a config workflow.
- Hide the visible title while keeping the node's stored label for admin reference.
