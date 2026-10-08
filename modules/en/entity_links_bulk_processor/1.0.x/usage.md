<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Links Bulk Processor rewrites the HTML in entity text fields in bulk — converting internal links to UUID-based entity links, resolving path aliases, validating contact links, mapping CSS classes, and converting legacy Drupal 7 media to `<drupal-media>`.

---

Entity Links Bulk Processor is a content-maintenance and migration-cleanup tool. It scans `text`, `text_long`, and `text_with_summary` fields on any content entity type and applies a configurable pipeline of transformations implemented in `entity_links_bulk_processor_process_attributes()`: internal `/node/N`, `/media/N`, `/taxonomy/term/N` and path-alias links get `data-entity-type`/`data-entity-uuid`/`data-entity-substitution` attributes (compatible with core Entity Links and Linkit); `mailto:`, `tel:`, `sms:`, and `fax:` links are validated and normalized; external URLs from configured domains are rewritten to internal paths; file paths and Drupal 7 media WYSIWYG tokens (`[[{"fid":123}]]`, `[[media:vid:123]]`) and `<img>`/`<video>` tags are converted to media entities and `<drupal-media>`; CSS classes on any element are remapped or removed; inline styles and redundant `title` attributes are stripped; anchor links are normalized. It runs from an admin UI (main form, step-by-step "Process Now" wizard, settings form, and a CSS-class discovery tool), as a batch, or through the `entity-links:bulk-process` Drush command (with `--dry-run`, `--filter`, `--ids`, `--languages`, CSV logging, and optional SQL backup). All routes require the trusted `administer entity links bulk processor` permission. The bundled `entity_links_autosave` submodule applies the same pipeline automatically on entity save. It depends on core Filter and Path Alias, and recommends Pathauto and Redirect.

---

- Convert `/node/123` links in migrated content into UUID-based entity links.
- Resolve Pathauto and manual path aliases (e.g. `/about-us`) to entity links.
- Follow Redirect-module chains to the final destination before linking.
- Skip unpublished entities when resolving links.
- Bulk-fix thousands of legacy Drupal 7 nodes after a D7→D10/11 migration.
- Convert Drupal 7 Media WYSIWYG tokens (`[[{"fid":...}]]`, `[[media:vid:123]]`) to `<drupal-media>`.
- Convert `<img>` and `<video>` tags to `<drupal-media>` entities, preserving alt/title/alignment.
- Normalize `mailto:` links to lowercase and validate the address format.
- Format `tel:` numbers to RFC 3966 or E.164 with a default country code.
- Validate and format `sms:` links while preserving the body parameter.
- Validate and format `fax:` links.
- Convert external URLs from your own domains into internal paths.
- Convert `/sites/default/files/...` file paths to referencing media entities.
- Remap CSS classes across all elements for a Bootstrap 3→5 or design-system migration.
- Remove unwanted CSS classes by mapping them to an empty value.
- Discover the most-used CSS classes in content and import mappings from the results.
- Export a CSV of discovered CSS classes for offline analysis.
- Strip inline `style=""` attributes from configured elements, with class-based exclusions.
- Remove `title` attributes that duplicate the link text, or report mismatches.
- Normalize in-page anchor (`#section`) links.
- Preview before/after transformations on real content without saving.
- Process only specific entity types, bundles, or entity IDs.
- Process all translations, or restrict to specific language codes.
- Detect cross-language aliases (a Spanish alias used inside English content).
- Automate cleanup in CI/CD with the Drush command's `--json` and `--fail-on-error` flags.
- Create a SQL backup before a Drush run and optionally restore it afterwards.
- Continuously normalize links on save using the `entity_links_autosave` submodule.
