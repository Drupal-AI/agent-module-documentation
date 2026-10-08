Entity Embed lets editors embed any Drupal entity — nodes, media, files, users, terms — directly inside a rich-text (CKEditor) field via a toolbar button, rendering each embedded entity through a configurable display plugin.

---

Entity Embed builds on core's Editor and Filter systems and the contrib Embed module to add a WYSIWYG button that inserts a `<drupal-entity>` tag into body text. When the text is rendered, the `EntityEmbedFilter` text filter swaps that placeholder for the fully rendered entity, respecting cache metadata and access. Each embed is drawn by an **Entity Embed Display** plugin (a plugin type this module defines), so the same entity can appear as a view mode, an image field formatter, a file link, or a custom renderer. Site builders create one or more **Embed buttons** (config entities from the Embed module) that scope which entity type, bundles, and display plugins an editor may choose, and optionally wire in an Entity Browser for selection. A dialog (`entity_embed.dialog` route) drives selection and per-embed options such as alt text, alignment, and caption. It ships CKEditor 4 and CKEditor 5 plugin integrations plus a Twig extension (`{{ entity_embed(...) }}`) for embedding from templates. Developers extend it with new display plugins and a family of alter hooks that filter available plugins per context and modify the rendered build.

---

- Embed a related article node inside the body of another node.
- Insert a media image into rich text with alt text and a caption.
- Embed a downloadable file as a styled link within content.
- Let editors pick an existing entity from an Entity Browser and drop it into text.
- Render an embedded node using a specific view mode (e.g. "Teaser").
- Show an embedded image using the image field formatter with a chosen image style.
- Create an Embed button restricted to a single entity type (e.g. Media only).
- Restrict an Embed button to selected bundles (e.g. only "Image" media).
- Limit which display plugins editors may choose per Embed button.
- Add multiple embed buttons to one text format for different entity types.
- Embed a user profile card inside an article.
- Embed a taxonomy term's rendered view inside body copy.
- Align an embedded entity left/right/center via the embed dialog.
- Add a caption under an embedded entity using the caption filter.
- Reuse the same media asset across many pages by embedding rather than re-uploading.
- Embed entities from a Twig template with the `entity_embed()` function.
- Provide a custom renderer for embeds via a new EntityEmbedDisplay plugin.
- Limit available display plugins for a given entity with a context alter hook.
- Strip contextual links from embedded entity output via `hook_entity_embed_alter()`.
- Override the rendered context of an embedded entity type before display.
- Migrate an existing CKEditor 4 entity-embed toolbar to CKEditor 5.
- Keep embedded content in sync — edits to the source entity flow to every embed.
- Enforce access control so users only see embeds they may view.
- Build media-rich landing pages without custom fields.
- Embed the same node with different displays in different places.
- Provide editors a consistent, governed way to insert media instead of raw HTML.
