Paragraphs Inline Entity Form lets editors create and embed Paragraphs entities directly inside a CKEditor 5 rich-text body, wiring together Entity Embed, Entity Browser and Inline Entity Form so a paragraph can be added to running text with almost no custom code.

---

The module bridges four contrib systems to make native Paragraphs embeddable in WYSIWYG content. It ships an **Entity Embed button** (`paragraphs_inline_entity_form`, in `config/install/embed.button.*`) and an **Entity Browser** (`paragraph_items`, iframe display, `config/install/entity_browser.browser.paragraph_items.yml`) whose single widget is this module's one plugin: the `paragraph_entity_form` Entity Browser widget (`src/Plugin/EntityBrowser/Widget/ParagraphEntityForm.php`), which extends `entity_browser_entity_form`'s `EntityForm`. That widget renders a **two-step flow** — first a grid of paragraph-type icons to pick a bundle (`entitySelectorForm()`, honouring the embed button's allowed `bundles`, resolved from the request path or the entity-browser widget context), then an Inline Entity Form (`#op: add`) to create the paragraph of that type. Hook implementations now live in an OOP hook class (`src/Hook/ParagraphsInlineEntityFormHooks.php`, `#[Hook]` attributes registered by `paragraphs_inline_entity_form.services.yml`; `.module` keeps `#[LegacyHook]` shims). They only alter forms and help: `hook_form_alter` attaches the module's dialog JS/CSS to entity forms and, inside the Entity Embed dialog for paragraph items, rewrites the "Back" button into an "Edit paragraph" AJAX action pointing at the existing `entity_browser.edit_form` route; `hook_entity_embed_values_alter` copies the UUID into `alt` to force a preview refresh; `hook_help` renders the README (escaped). There is **no admin settings page** (`configure` is null), **no routes**, and **no permissions of its own** — reaching the picker requires the Entity Browser `access paragraph_items entity browser pages` permission, and everything else is configuration on the embed button and text format. Setup: tick the embed button's paragraph bundles at `/admin/config/content/embed`, then add the `Paragraphs` embed button to a text format's CKEditor 5 toolbar at `/admin/config/content/formats`, enabling the "Display embedded entities" filter and allowing the `<drupal-entity>` markup. Requires Drupal 10.3+/11/12. A bundled example submodule (`paragraphs_inline_entity_form_example`) provides a demo content type and paragraph types.

---

- Embed a Paragraph (e.g. an image, gallery, or embed card) inline within a node's rich-text body.
- Give editors a "Paragraphs" CKEditor 5 toolbar button that opens a paragraph-type picker.
- Reuse existing native Paragraphs bundles inside WYSIWYG content without a dedicated field.
- Let editors choose a paragraph type from an icon grid before filling in its fields.
- Create a brand-new paragraph inline via Inline Entity Form during content authoring.
- Edit an already-embedded paragraph from the Entity Embed dialog ("Edit paragraph" button).
- Restrict which paragraph bundles are embeddable per embed button via its `bundles` setting.
- Mix free-flowing prose with structured paragraph components in a single body field.
- Add media/social embeds (YouTube, Twitter, Instagram, Facebook) as paragraphs in article bodies.
- Provide a Bootstrap/column-style layout paragraph inside body text (single-level).
- Offer a lower-code alternative to Paragraphs Entity Embed (config-only, no custom module code).
- Standardise embedded rich content across content types using shared paragraph types.
- Present a preview view mode of the embedded paragraph in the editor and rendered output.
- Enable content teams to build magazine-style articles with reusable component blocks.
- Wire Entity Browser's iframe selector to paragraph creation without writing a widget.
- Let a custom paragraph type with an icon appear (with thumbnail) in the embed picker.
- Spin up a working demo with the example submodule to evaluate the workflow.
- Trigger an automatic preview refresh after embedding so editors see the paragraph immediately.
- Keep embed configuration portable as ordinary Drupal config (embed button + entity browser).
- Support multiple embed buttons/text formats each scoped to different paragraph bundles.
- Gate paragraph embedding behind the `access paragraph_items entity browser pages` permission per role.
- Run on Drupal 10.3, 11, or 12 with core's CKEditor 5.
