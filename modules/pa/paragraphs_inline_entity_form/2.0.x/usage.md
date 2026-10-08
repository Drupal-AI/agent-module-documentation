Paragraphs Inline Entity Form lets editors create and embed Paragraphs entities directly inside a CKEditor 5 rich-text body, wiring together Entity Embed, Entity Browser and Inline Entity Form so a paragraph can be added to running text with almost no custom code. Version 2.0.x requires Drupal 10.3+/11 and drops the old `drupal/entity` dependency.

---

The module bridges four contrib systems to make native Paragraphs embeddable in WYSIWYG content. It ships an **Entity Embed button** (`paragraphs_inline_entity_form`, in `config/install/embed.button.*`) and an **Entity Browser** (`paragraph_items`, iframe display with `auto_open: true`, `config/install/entity_browser.browser.paragraph_items.yml`) whose single widget is this module's one plugin: the `paragraph_entity_form` Entity Browser widget (`src/Plugin/EntityBrowser/Widget/ParagraphEntityForm.php`), which extends `entity_browser_entity_form`'s `EntityForm`. That widget renders a **two-step flow** — first a grid of paragraph-type icons to pick a bundle (`entitySelectorForm()`, honouring the embed button's allowed `bundles`; if none are ticked, all types are offered), then an Inline Entity Form (`#op: add`) to create the paragraph of that type. In 2.0.x the hooks are **class-based**: `src/Hook/ParagraphsInlineEntityFormHooks.php` implements `help`, `form_alter` and `entity_embed_values_alter` via `#[Hook]` attributes, registered as an autowired service, while the thin `.module` keeps only `#[LegacyHook]` shims. `form_alter` attaches the module's dialog JS/CSS library to entity forms and, inside the Entity Embed dialog for paragraph items, rewrites the "Back" button into an "Edit paragraph" AJAX action; `entity_embed_values_alter` copies the entity UUID into `alt` to force a preview refresh; the new `hook_help()` renders the module `README.md` (escaped) on the help page. There is **no admin settings page** (`configure` is null) and **no permissions of its own** — reachability is governed by Entity Browser's `access paragraph_items entity browser pages` permission plus the text format's *use* permission, and what fields an editor may set is governed by paragraph/field access through Inline Entity Form. Setup: enable the embed button's paragraph bundles at `/admin/config/content/embed`, add the `Paragraphs` button to a CKEditor 5 text format at `/admin/config/content/formats` (enable the "Display embedded entities" filter and allow the `<drupal-entity>` markup), then grant the two permissions above. A bundled example submodule (`paragraphs_inline_entity_form_example`) provides a demo content type and nine paragraph types.

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
- Read the module's README straight from the admin help page (`/admin/help/paragraphs_inline_entity_form`).
- Keep embed configuration portable as ordinary Drupal config (embed button + entity browser).
- Support multiple embed buttons/text formats each scoped to different paragraph bundles.
- Upgrade a Drupal 10.3+/11 site from the 1.x line to the class-based-hooks 2.0.x release.
