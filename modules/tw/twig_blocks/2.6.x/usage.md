Twig Blocks adds a `render_block()` Twig function so a theme template can render a placed block (config Block entity) by its machine ID, optionally overriding its settings inline.

---

The module registers a Twig extension (`Drupal\twig_blocks\Twig\RenderBlock`, tagged `twig.extension`) that exposes one function: `render_block(block_id, configuration = {})`, marked `is_safe: html`. It loads the `block` config entity for `block_id`, and — if a `configuration` array is passed — **merges those values into the block's `settings` and saves the entity**, then renders it via the `block` view builder and returns `{ '#markup': … }`. The module also ships a standalone service, `twig_blocks.block_view_builder` (`Drupal\twig_blocks\View\BlockViewBuilder`), which builds a render array directly from a **block plugin ID** (not a config entity): it instantiates the plugin, injects runtime contexts, runs the plugin's `access()` check, handles title blocks, applies the standard `#theme => block` wrapper, and attaches cacheability. There is no config UI, no permissions, no schema, and no dependencies beyond core. The primary use is letting front-end developers drop an existing configured block into a specific place in a Twig template without going through the Block layout / regions system. Note the `render_block()` Twig path persists config changes when you pass overrides, so passing per-request dynamic settings there will write to the database on render.

---

- Render a configured block (e.g. a menu, branding, or custom block) inside a page or node template.
- Place a block in an exact spot in Twig markup that no theme region covers.
- Output a search-form block within a custom hero component template.
- Embed a "Powered by Drupal" or social-links block in a footer template.
- Render a block by ID from a paragraph or Layout Builder component template.
- Override a block's label from the template via the second argument (`{label: 'Example'|t}`).
- Pass block plugin settings inline when rendering (e.g. a custom setting value).
- Reuse one configured block in multiple templates without re-placing it per region.
- Render a menu block in a mega-menu Twig partial.
- Drop a language-switcher block into a specific header layout slot.
- Include a promotional/CTA block mid-content in an article template.
- Render a block conditionally inside `{% if %}` logic in a template.
- Build component-driven themes that compose blocks in Twig rather than regions.
- Render a views block by its block ID in a custom sidebar partial.
- Add a contact-form block to a landing-page template.
- Render the same block in different templates with different labels.
- Use the `twig_blocks.block_view_builder` service to render a block **plugin** by ID from custom PHP.
- Programmatically build a block plugin render array with runtime contexts and access checks applied.
- Compose dashboard-style pages by rendering several blocks from one template.
- Keep block placement logic in the theme layer for tightly designed components.
