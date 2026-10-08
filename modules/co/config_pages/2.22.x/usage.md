Config Pages lets you build fieldable "singleton" pages for site-wide settings — you add Field UI fields to a config page type and edit one shared page instead of writing a custom settings form.

---

Config Pages provides a `config_pages` content entity whose bundles are `config_pages_type` config entities, so each "type" is effectively one editable settings page you build with Field API (text, images, entity references, multi-value drag & drop, etc.) rather than a hand-coded Form API form. You create a type at **Admin → Structure → Config pages** (`entity.config_pages.collection`), optionally mount it at a custom menu path, add fields via Field UI, and then edit the single stored entity. Config pages are **context-aware**: a pluggable `config_pages_context` system (a Language context ships in the box) can store a distinct set of values per language, per domain, or per any custom context, with fallback values. Values are read in code through the `config_pages.loader` service (`getValue()`, `getFieldView()`) or the `config_pages_config()` helper, exposed to Twig via a `config_pages_field()` function, surfaced to Token as a `config_page` token type, and set/read from the CLI with the module's Drush commands. It replaces the pattern of creating a throwaway content type just to hold one node of settings, and is a flexible nodequeue replacement when combined with an entity-reference field and Views.

---

- Build a global site-settings page (phone, address, social links) without writing a settings form.
- Create a homepage "hero" config page with an image field and CTA link editors can change.
- Store a singleton "footer" config page mounted at a friendly admin path.
- Add fields to a config page type through Field UI just like any content entity bundle.
- Mount a config page at a custom menu path (e.g. `admin/config/mysettings`) so clients find it easily.
- Keep per-language values for the same settings page using the built-in Language context.
- Keep per-domain settings with a custom or Domain-based context plugin.
- Provide fallback values for a context when a specific context has no saved page.
- Read a single field value in code via `config_pages.loader`'s `getValue()`.
- Render a config page field in a template with the `config_pages_field()` Twig function.
- Expose config page field values as tokens (`[config_page:...]`) for use elsewhere.
- Set a config page field value from the command line with `drush cpsfv`.
- Read a config page field value from the command line with `drush cpgfv`.
- Place a config page's rendered output as a block via the ConfigPages block plugin.
- Gate visibility of other blocks on a config page field value with the value-access condition.
- Replace nodequeue by using an entity-reference field with a Views autocomplete source.
- Give a config page a controlled "clear values" (purge) action to reset it.
- Import/copy values from one context to another for the same config page type.
- Manage a multi-value, drag-and-drop ordered list of references as editable settings.
- Grant per-type view/edit permissions so an editor can change only certain config pages.
- Store rich text or file uploads as reusable site-wide content fragments.
- Export config page *types* (and their fields) as configuration between environments.
- Build a "call to action banner" config page reused across many templates.
- Provide a themeable settings entity with configurable view modes and display.
- Add a custom context plugin (e.g. per-role or per-section) via the module's plugin API.
- Deploy the config page type definition with `drush config:export` like any config entity.
