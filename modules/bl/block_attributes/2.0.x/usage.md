Block Attributes lets site builders attach arbitrary HTML attributes (class, id, data-*, etc.) to blocks by defining an attribute list globally and filling in per-block values on the block configuration form.

---

Admins define which attributes are available in a single YAML config object (`block_attributes.config`, key `attributes`) via the settings form at `/admin/structure/block/attributes` (permission `access administration pages`). Each attribute can carry a `label`, a `description`, and optional `options` (which turns the per-block input into a select list instead of a textfield). The module then alters every block configuration form (`hook_form_block_form_alter`) to add an "Attributes" fieldset with one input per defined attribute; submitted values are stored in the block's own configuration under `settings.attributes`. At render time `block_attributes_preprocess_block` merges those values into the block's `attributes` render array (space-separated values become multiple entries). A blocklist (`BlockAttributesChecker::isAttributeAllowed`) rejects JavaScript event-handler attribute names matching the regex `^on[a-z]+$`, applied both when saving the config and when applying attributes at render. The default config ships one attribute: `class`. There is no config schema and no dedicated permission — both the definition form and the per-block form rely on core permissions (`access administration pages` and `administer blocks`). Note: attribute names and values are escaped by Drupal's `Attribute` renderer.

---

- Add a custom CSS `class` to a specific block.
- Give a block an `id` for anchor links or JS targeting.
- Attach `data-*` attributes to blocks for JavaScript behaviours.
- Add ARIA attributes (e.g. `role`, `aria-label`) to blocks for accessibility.
- Define a reusable list of allowed attributes site-wide in YAML.
- Offer editors a dropdown of preset values for an attribute via `options`.
- Label and describe each attribute so editors know what to enter.
- Add a `lang` or `dir` attribute to an individual block.
- Tag blocks with analytics/tracking hooks via data attributes.
- Apply a `title` attribute to a block wrapper.
- Standardise block styling hooks across a theme.
- Add multiple classes at once (space-separated values become separate classes).
- Provide per-block styling without writing template overrides.
- Give A/B-testing or personalisation tools DOM hooks on blocks.
- Prefill an attribute's default value from the definition.
- Restrict an attribute input to a fixed set of options.
- Manage all available attributes from one settings page.
- Support the YAML Editor module for easier config editing.
- Add structured-data or microformat attributes to blocks.
- Quickly toggle block-level classes without redeploying code.
