Embed is a low-level framework that lets other modules add "embed buttons" to CKEditor toolbars so authors can insert rich objects (entities, media, tweets, etc.) into formatted text. It provides no user-facing embeds itself — it is the shared plumbing that modules like Entity Embed and Media build on.

---

Embed defines an `embed_button` configuration entity and an `EmbedType` plugin type, giving other modules a consistent way to register embeddable object types and expose them as toolbar buttons in CKEditor 4 and CKEditor 5. Each embed button pairs an EmbedType plugin (which supplies a configuration form and settings) with an icon and machine name; buttons appear in the text-format toolbar and open a dialog that returns markup inserted into the editor. The module handles the CKEditor integration (including deriving CKEditor 5 plugins from configured buttons), an AJAX preview controller (`/embed/preview/{filter_format}`), button-icon upload settings, and access checks tying button use to text-format permissions. Buttons are managed at Admin → Configuration → Content authoring → Embed buttons (`entity.embed_button.collection`) and are exportable configuration. Developers implement `EmbedType` plugins and extend `EmbedCKEditorPluginBase`/`EmbedCKEditor5PluginBase` to ship their own embed experiences. A `hook_embed_type_plugins_alter()` hook allows altering registered embed types. Because it is purely a framework, Embed is almost always installed as a dependency rather than on its own.

---

- Provide the shared toolbar-button framework that Entity Embed depends on.
- Underpin the core-adjacent Media/Media Library embedding of media entities in rich text.
- Register a custom "embed button" that inserts a specific object type into CKEditor.
- Add embed buttons to both CKEditor 4 and CKEditor 5 toolbars from one configuration.
- Define a new `EmbedType` plugin for a bespoke embed (e.g. a product card or map).
- Supply a configuration form for an embed type via the plugin's `embed_form_class`.
- Upload and manage per-button icons shown in the editor toolbar.
- Configure the file scheme and upload directory used for button icons.
- Export embed button definitions as YAML config for deployment across environments.
- Gate who can manage embed buttons with the `administer embed buttons` permission.
- Tie an embed button's availability to a text format's `use` access.
- Preview embedded content via the AJAX `/embed/preview/{filter_format}` endpoint.
- Insert rendered markup back into the editor using the `EmbedInsertCommand` AJAX command.
- Alter another module's embed type definitions with `hook_embed_type_plugins_alter()`.
- Derive CKEditor 5 plugins automatically from configured embed buttons.
- Build a "tweet embed" or "video embed" button on top of the framework.
- Enforce that a required filter is enabled before an embed button can be used.
- Share one dialog/insert workflow across many different embed types.
- Standardize embed markup so text filters can process it consistently.
- Extend `EmbedCKEditorPluginBase` to integrate a custom button with CKEditor.
- Provide site builders a UI to add, edit, and delete embed buttons without code.
- Serve as a dependency for contrib embedding modules rather than end-user config.
- Invalidate CKEditor plugin caches automatically when embed buttons change.
- Keep embed configuration schema-validated via `config/schema`.
