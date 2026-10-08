Lets you set a custom HTML `id` and extra CSS classes (on the block wrapper, its title, and its content) for any placed block, straight from the block configuration form.

---

Block ID adds four optional fields to the core block configuration form (via
`hook_form_block_form_alter`), stored as block **third-party settings** under the `block_id`
namespace: a custom **Block ID** (`id`), plus **Title**, **Content**, and **Block** CSS class fields
(`title_class`, `content_class`, `class_block`). The form fields — and therefore the feature — are
only shown to users with the **"administer block id"** permission. On save, empty values are unset
(`hook_block_presave`) so nothing clutters the block config, and a submit validator enforces that a
custom Block ID is **unique** across all blocks (rejecting duplicates). At render time
(`hook_preprocess_block`) the stored `id` replaces the block wrapper's `id` attribute, and each
class string is split on spaces and added to the relevant attributes array — the class values are
passed through `Html::cleanCssIdentifier()`, while the `id` value is applied as-is (relying on
Drupal's attribute-rendering to escape it). The module has no settings page, no config schema, and
no Drush; you use it entirely from *Structure › Block layout › Configure* on each block. Requires the
core Block module.

---

- Give a block a stable, predictable HTML `id` for CSS targeting or JavaScript hooks.
- Create an in-page anchor (`#section`) by setting a block's ID and linking to it.
- Add utility/BEM CSS classes to a block wrapper without writing a preprocess hook.
- Add classes specifically to a block's title element for styling headings.
- Add classes to a block's content region independently of the wrapper.
- Apply a theme/framework component class (e.g. a grid or card class) to a placed block.
- Target a specific block from analytics or A/B-testing scripts via its custom ID.
- Give editors control of block styling hooks without touching Twig templates.
- Ensure a block's ID stays consistent across deployments (it's block config, exportable).
- Prevent duplicate block IDs on a page thanks to the built-in uniqueness check.
- Scope custom CSS to one block instance using a unique ID selector.
- Add multiple classes at once (space-separated) to a block wrapper.
- Attach smooth-scroll or scrollspy behavior to a block via a known ID.
- Distinguish otherwise-identical blocks (e.g. two menus) with different IDs/classes.
- Integrate a block with a design system by adding its class names.
- Restrict who can edit block IDs/classes via the dedicated permission.
- Provide accessibility landmarks by giving key blocks meaningful IDs.
- Keep block markup clean by only emitting IDs/classes that are actually set.
- Add print-specific or state classes to a block for conditional styling.
- Reference a block ID from a skip-link or table-of-contents navigation.
