<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Flattener service, enforcement & constants

## Service `flat_taxonomy.taxonomy_flattener` (`Drupal\flat_taxonomy\Flattener`)

Constructed with `@entity_type.manager`. Un-nests a vocabulary's terms:

- `flatten(Vocabulary $vocabulary): void` — loads the root-level tree and recursively flattens.
- `flattenSubtree(Term $term, int $weight): void` — sets `$term->parent = 0`, assigns an
  incrementing `weight`, saves, then recurses into the term's children so the whole subtree ends
  up at the root, order preserved.

Called automatically when the Flat checkbox is ticked on the vocabulary form; call it directly
after setting the third-party flag in code to migrate existing nested terms.

## Enforcement hooks (in `flat_taxonomy.module`)

- `flat_taxonomy_form_taxonomy_vocabulary_form_alter` + `_form_builder` — the Flat checkbox and
  storing/removing the `flat_taxonomy.flat` third-party setting.
- `flat_taxonomy_form_taxonomy_term_form_alter` — hides `relations.parent` and adds a validate
  handler that errors on any submitted parent.
- `flat_taxonomy_taxonomy_term_presave` — forces `parent = 0` (with a warning) for flat vocabs.
- `flat_taxonomy_entity_operation_alter` — removes the `add-child` term operation.
- `flat_taxonomy_form_taxonomy_overview_terms_alter` — strips depth/parent `#tabledrag` groups.
- `flat_taxonomy_requirements` — runtime warning if Hierarchy Manager manages the same vocab.

## Constants (`Drupal\flat_taxonomy\FlatConstants`)

- `FLAT_TAXONOMY_FLAT = 1`
- `FLAT_TAXONOMY_NORMAL = 0`

The third-party setting value is compared against `FLAT_TAXONOMY_FLAT`.
