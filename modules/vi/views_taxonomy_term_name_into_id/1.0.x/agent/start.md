<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Taxonomy Term Name Into ID — agent index

Adds one Views **argument (contextual filter) validator** plugin, id
**`taxonomy_term_name_into_id`** ("Taxonomy term name as ID"), which converts a term **name**
argument to its term **ID** so the efficient "Has taxonomy term ID" filter can use readable URLs.
No settings form, **no configure route**, no permissions, no services, no Drush. You configure it
inside a view.

- **Use the validator on a contextual filter: plugin id, options, where it lives in view config** →
  [configure/argument-validator.md](configure/argument-validator.md)

Key facts:
- Plugin: `Drupal\views_taxonomy_term_name_into_id\Plugin\views\argument_validator\TermNameAsId`
  extends core `TermName` (`@ViewsArgumentValidator(id = "taxonomy_term_name_into_id", ...)`).
- In view config it appears as `...arguments.<arg>.validate.type: taxonomy_term_name_into_id`
  with `specify_validation: true` and options under `validate_options` (`bundles`, `transform`,
  `access`, `operation`).
- Assumes term names are unique; set `bundles` (vocabulary) when they are not.
