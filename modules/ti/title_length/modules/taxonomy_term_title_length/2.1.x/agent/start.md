<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Taxonomy term title length — agent index

The `title_length` submodule that widens the **taxonomy term `name`** column above 255
(default 500). Depends on `taxonomy` + `title_length`. No UI, no config object, no permissions.

- **The `taxonomy_term_title_length.taxonomy_term` service, settings override, install/uninstall
  behavior** → [api/taxonomy-term.md](api/taxonomy-term.md)

Key facts:
- Class `Drupal\taxonomy_term_title_length\TaxonomyTermTitleLength extends EntityTitleLength`;
  entity type `taxonomy_term`, title field `name`. Service id: `taxonomy_term_title_length.taxonomy_term`.
- Default length **500** (`EntityTitleLengthInterface::DEFAULT_LENGTH`); original 255.
- Override before/after install: `$settings['taxonomy_term_title_length_chars'] = <n>;` in `settings.php`.
- Re-apply after a change: `drush title_length:update taxonomy_term` (command lives in the parent).
- Effect lives in the DB schema: the term data table's `name` column (and revision table when
  revisionable) becomes `varchar(<length>)`; a `hook_entity_base_field_info_alter()` sets the
  base-field `max_length`.
- Uninstall shrinks back to 255 but throws if any term/revision name already exceeds 255.
- Shared machinery (abstract service, Drush command, the `changeLength()` internals) is in the
  parent: [../../../../2.1.x/agent/start.md](../../../../2.1.x/agent/start.md).
