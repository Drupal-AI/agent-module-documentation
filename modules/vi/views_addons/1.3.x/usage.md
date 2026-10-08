<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Addons adds two handlers to Views: an "Advanced Custom Text" field that renders custom markup with a wider, admin-configurable HTML tag allow-list than core's Custom Text field, and an "Add Entity Link" area handler that places an access-checked link to a node/user/taxonomy add form in a view's Header, Footer, or No-results area. Depends only on core `views`; no permissions, routes, services, or config forms of its own.

---

The module implements `hook_views_data_alter()` (in `views_addons.views.inc`) to register two global Views handlers under the `views` table. The **Advanced Custom Text** field (`views field: views_addons_custom_advanced`, class `CustomAdvanced` extending core `Drupal\views\Plugin\views\field\Custom`) exists because the core Custom Text field pushes its output through `Xss::filterAdmin()`, which strips tags such as `<svg>`, `<picture>`, and `<source>`. `CustomAdvanced` overrides `viewsTokenReplace()` to instead run `strip_tags()` against a tag list = `Xss::getAdminTagList()` plus a per-field "additional allowed tags" textfield (default `svg g circle text`), so those tags survive; Twig token replacement is preserved via an `inline_template` build with a `#post_render` strip_tags. The **Add Entity Link** area handler (`views area: views_addons_add_entity`, class `AddCoreEntity` extending `AreaPluginBase`) builds a `Link` to `node.add` / `entity.user.add_form` / `entity.taxonomy_term.add_form` for a configured entity type + bundle/vocabulary, applies configurable link text and CSS classes, and gates visibility on the entity's `createAccess()` handler with `user.permissions` cache context and appropriate cache tags. There is no style plugin, no filter, no sort, no argument, no query alteration, and no config schema directory — just these two handlers.

---

- Output an `<svg>` inline graphic (or `<picture>`/`<source>` responsive markup) as a Views field, which core's Custom Text would strip.
- Add a Views "Global: Advanced Custom Text" field and type raw markup that includes tags core normally filters.
- Configure the extra allowed tags per field (e.g. add `picture source video audio` to the default `svg g circle text`).
- Embed a small chart/icon built from `<svg><g><circle><text>` directly inside a view row.
- Use Views replacement tokens (e.g. `{{ title }}`) inside custom markup that also contains SVG.
- Render a static block of custom HTML in a view row without creating a separate field formatter.
- Place an "Add new article" button in a view's Header that only appears for users who can create articles.
- Put an "Add term" link in a taxonomy-listing view's footer, scoped to a chosen vocabulary.
- Show an "Add user" link in an admin people-style view, hidden unless the viewer can create users.
- Give the add-entity link custom CSS classes to style it as a button.
- Customize the add-entity link text (e.g. "Create new event") per view.
- Show a call-to-action add link in the "No results behavior" area so empty listings invite content creation.
- Build a content-dashboard view whose header has a bundle-specific create button.
- Provide a taxonomy-vocabulary term-management view with an inline add-term link that respects permissions.
- Replace a hand-coded add-content link block with a per-view, access-checked area handler.
- Combine the Advanced Custom Text field with contextual data to render decorative or informational SVG per row.
- Use the field to inject markup that a WYSIWYG/text-format pipeline would otherwise restrict, inside a trusted view.
- Reuse one view definition across bundles by swapping the add-entity area's configured bundle.
- Provide a lightweight alternative to writing a custom Views field/area plugin for these two narrow needs.
