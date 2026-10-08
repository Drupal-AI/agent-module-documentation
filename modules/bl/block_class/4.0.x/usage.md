Block Class lets site builders add custom CSS classes, arbitrary HTML attributes, and a custom HTML ID to any block directly from the block configuration form, without writing a preprocess function or template override.

---

Block Class extends core's Block module by adding fields to every block's configuration form where you can type one or more CSS classes, define HTML attributes (name/value pairs such as `data-*`, `aria-*`, `role`), and set a custom HTML `id` on the block's wrapper. These values are stored with the block config and applied at render time through a `hook_preprocess_block()` implementation that merges them into the block's `attributes`. A settings form at Admin → Configuration → Content → Block Class controls behavior globally: field type (single vs. multiple textfields), case handling, whether attributes and autocomplete are enabled, ID replacement, per-block quantity limits for classes and attributes, maximum lengths, and special-character rules. An autocomplete feature suggests previously used class and attribute names so styling stays consistent across a site. Administrative list pages show which blocks have classes or attributes assigned, and a bulk-operations tool can add, rename, or delete a class/attribute across many blocks at once (with confirmation steps). Everything is gated by the single "administer block classes" permission. The module is purely a styling/markup convenience — it has no plugins or Drush commands — but it is a very widely used building block for theming Drupal sites without custom code.

---

- Add a CSS class like `hero` or `bg-dark` to a block from the block config form.
- Assign multiple utility classes (e.g. Tailwind/Bootstrap) to a single block.
- Give a block a custom HTML `id` for anchor links or JavaScript targeting.
- Add `data-*` attributes to a block for front-end scripts.
- Add ARIA attributes (`role`, `aria-label`) to a block for accessibility.
- Style a specific block instance without writing a template override.
- Keep class naming consistent via autocomplete of previously used classes.
- Enforce a maximum length on class, ID, and attribute values.
- Limit how many classes or attributes an editor may add per block.
- Bulk-add a class to many blocks at once via the bulk-operations tool.
- Bulk-rename a class across all blocks that use it.
- Bulk-delete an obsolete class or attribute site-wide.
- Review which blocks carry a given class from the admin list pages.
- Replace the block's default machine-name-based ID with a custom one.
- Configure case handling (lowercase/standard) for generated identifiers.
- Allow or forbid special characters in class names.
- Choose between a single textfield or multiple textfields for entering classes.
- Add a `role="navigation"` attribute to a menu block.
- Tag promotional blocks with campaign-specific `data-` hooks for analytics.
- Provide theme developers with predictable selectors per block.
- Restrict block-class editing to trusted roles via the permission.
- Paginate large block lists with a configurable items-per-page setting.
- Add hook targets for JavaScript behaviors to specific blocks.
- Standardize spacing/layout classes across a component library of blocks.
- Apply attributes needed by third-party widgets embedded in blocks.
