Default Content Tools gives site operators control over Drupal core's Default Content API: it can globally suppress importing default content, and delete content that a module or recipe has already imported.

---

The module layers two capabilities onto core's Default Content / recipe system. A single site-wide setting (`suppress_import`) makes a `PreImportEvent` subscriber skip every discovered default-content item, so no default content is imported at all. Separately, an admin confirm form and a `RecipeAppliedEvent` subscriber can delete content that was already imported: the form deletes the shipped content of a chosen module or Composer package (reachable as a link on the module list and as an operation on Reports > Recipes), while the subscriber automatically deletes a recipe's content once that recipe finishes applying, for every recipe named in the `delete_recipes` list. Two config actions let recipes add or remove entries from that list additively, and when `recipe_tracker` is installed a catch-up subscriber sweeps its persisted log so deletion still happens when the requesting recipe was applied after the providing recipe. Deletion works by loading each entity by its UUID (from the content folder's `_meta`) via the entity repository and deleting it; it is idempotent and logs each deletion to the `default_content_tools` channel. All destructive operations require `administer modules`; the settings form requires `administer site configuration`.

---

- Prevent a module's default content from being imported at all when you enable it, by turning on Suppress Default Content Import first.
- Stand up a site-building recipe without dragging in its demo/sample content.
- Delete the demo catalogue a recipe shipped after you have replaced it with real content.
- Remove default content that a module created, straight from the Extend (module list) page via the per-module "Default Content" link.
- Delete a recipe's imported content from Reports > Recipes using the "Delete default content" operation (requires `recipe_tracker`).
- Clean up content imported by a specific installed Composer package by passing its package name to the delete form.
- Automatically strip a composed sub-recipe's content the moment a branded/parent recipe finishes applying, with no manual step.
- Let a branded recipe compose a neutral demo recipe and mark it for content deletion, so the demo entities never persist on the finished site.
- Opt a previously-marked recipe's content back out of automatic deletion from a later recipe layer that wants to keep it.
- Combine several composed recipes that each mark their own content for deletion without one clobbering another's entries.
- Ensure content deletion happens even when the recipe requesting deletion is applied after the recipe that provided the content (via the recipe_tracker catch-up pass).
- Keep a standing rule that a given recipe's content is always removed however it gets applied, including via Project Browser or `drush recipe:apply` on a live site.
- Reset a demo/staging site to a content-free baseline while keeping configuration and modules in place.
- Undo an accidental default-content import during development by deleting the exact entities the importer created.
- Audit which installed modules ship default content: the delete link only appears for extensions whose `content/` folder actually contains data.
- Script suppression and deletion into a site template so downstream installs get a clean content state.
- Toggle default-content import suppression on and off from Configuration > Content authoring > Default Content Tools without editing code.
- Manage the deletion list declaratively through configuration (`default_content_tools.settings:delete_recipes`) as part of config-managed deployments.
- Use it alongside the contributed Default Content module to control the lifecycle of exported/imported content.
- Provide a repeatable way to demonstrate a recipe to stakeholders, then wipe its sample content before go-live.
