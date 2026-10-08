<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Entity Embed lets content editors embed a View directly inside a rich-text (CKEditor) field, rendering the chosen view/display inline where a `<drupal-views>` tag is placed.

---

Built on the Embed / Entity Embed framework, the module registers an `embed_views` **EmbedType** and ships an embed button (config `embed.button.views`) so a **Views Embed** button can be added to a CKEditor 5 toolbar. When clicked it opens a dialog (route `views_entity_embed.dialog`) to pick a View, a display, optionally override the title, and supply contextual-filter arguments. The selection is stored in the text as a `<drupal-views>` element carrying `data-view-name`, `data-view-display` and a JSON `data-view-arguments` attribute (override_title, title, filters). A text filter, **`views_embed`** ("Display embedded views"), then finds `<drupal-views>` elements at render time, builds and executes the referenced View (applying the title override and contextual arguments) and replaces the tag with the rendered view, wrapped by the `views_entity_embed_container` theme. An embed button of type Views can optionally restrict which Views and which display plugins are allowed. There is no module settings page; you configure it by enabling the filter on a text format, allowing the `<drupal-views>` tag, and creating/placing the embed button.

---

- Embed a "Latest articles" View inside a landing-page body field.
- Drop a filtered product listing View into a rich-text description.
- Let editors insert a View through a CKEditor toolbar button, no code required.
- Override an embedded View's title per placement from the embed dialog.
- Pass contextual-filter arguments to an embedded View from the WYSIWYG dialog.
- Show a block-display View inline within article content.
- Restrict an embed button so only certain Views may be embedded.
- Restrict which View display plugins are allowed for an embed button.
- Reuse one View across many pages by embedding it in body copy.
- Build a curated homepage from rich text plus embedded Views.
- Insert a related-content View at a chosen point in an article.
- Embed a calendar or events View inside editorial content.
- Add a `<drupal-views data-view-name data-view-display>` element by hand in source view.
- Enable the "Display embedded views" filter on Full HTML to render embedded views.
- Allow the `<drupal-views>` tag (with its data-view-* attributes) in Limit allowed HTML tags.
- Create multiple embed buttons scoped to different sets of Views.
- Give marketers a way to place dynamic listings without touching Views admin.
- Embed a taxonomy-filtered View using a contextual argument supplied at embed time.
- Present the same View with different titles in different articles.
- Combine embedded Views with other embed buttons (media, entities) in one editor.
- Render a View inline through the `views_embed` text filter on any format that allows it.
- Edit a previously embedded View via the dialog to change display or arguments.
- Add dynamic, query-driven content blocks to otherwise static rich-text pages.
