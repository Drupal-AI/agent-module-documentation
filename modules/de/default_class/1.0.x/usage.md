Default Class adds descriptive CSS classes (block/region, node, user, taxonomy term) to rendered markup so themers can target them without writing preprocess code.

---

Default Class is a small, zero-configuration theming helper. When enabled it hooks into Drupal's render preprocessing to attach extra, information-bearing CSS classes drawn from data Drupal already has. `hook_preprocess_block()` tags every block with a normalized `block` class, its plugin id (except plain block_content blocks), its provider module, its placed region (`block--<region>`), and — for content blocks — its bundle (`block--block-content--<type>`). `hook_preprocess_html()` adds identifiers to the page element on canonical entity pages: node pages get `node-<id>` and `node-<bundle>`, user pages get `user-<uid>` and `user-<account-name>`, and taxonomy-term pages get `term-<id>`, `term-name-<slugified-label>`, and `term-vid-<vocabulary>`. There are no settings, routes, permissions, services, or plugins — installing the module is the whole configuration. All class strings that derive from machine ids are normalized with `Html::getClass()`, and every class ultimately flows through Drupal's `Attribute` rendering, which escapes attribute values on output.

---

- Enable the module to get block region classes without writing a custom `hook_preprocess_block()` in your theme.
- Target a specific placed region with CSS via the `block--<region>` class (e.g. `.block--sidebar-first`).
- Style all blocks provided by a given module using the provider class (e.g. `.system`, `.views`, `.user`).
- Style blocks by their plugin id (e.g. a specific views block or menu block) using the normalized `plugin_id` class.
- Style custom content blocks by their bundle with `block--block-content--<type>` (e.g. `.block--block-content--banner`).
- Apply a baseline `block` class consistently across all blocks for shared spacing or typography rules.
- Add per-node CSS by targeting `node-<nid>` on the page/body element for one-off page styling.
- Add per-content-type page styling with the `node-<bundle>` class (e.g. `.node-article`, `.node-page`).
- Give an editor-facing preview page distinct styling by keying off the node id class.
- Style a specific user's profile page using the `user-<uid>` class.
- Style a user's page by account name using `user-<name>` for handle-specific theming.
- Style a taxonomy term page by term id using `term-<tid>`.
- Style a term page by its (slugified) name using `term-name-<label>` for readable selectors.
- Style all term pages in a vocabulary at once using `term-vid-<vocabulary>` (e.g. `.term-vid-tags`).
- Provide JavaScript hooks: scripts can `document.body.classList.contains('node-article')` to run page-type-specific behavior.
- Build a design system where region and bundle classes are stable, predictable selectors instead of theme-specific overrides.
- Replace ad-hoc per-project preprocess snippets that add the same identity classes across many sites.
- Drive conditional layout (e.g. hide a sidebar) based on the current node type class on the page element.
- Give front-end developers a consistent contract of classes to build against without inspecting Twig templates.
- Debug rendering by reading a block's provider/region/bundle straight from its DOM classes.
- Combine with a base theme so region and provider classes are available regardless of the active theme's templates.
