<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# block_visibility_conditions_taxonomy — agent start

Submodule of **block_visibility_conditions**. Ships one Condition plugin:
`not_taxonomy_vocabulary` ("Not Taxonomy Vocabulary"), class
`NotTaxonomyVocabulary extends NotConditionPluginBase` with
`CONTENT_ENTITY_TYPE = 'taxonomy_vocabulary'`. `*.info.yml` depends only on `drupal:taxonomy`
(relies on the parent's base class but does not list the parent module).

Hides a block only on the checked vocabularies' term pages; shows it on all other pages.
Configured per block in the core Block layout / Layout Builder visibility form — no settings
page, no permissions, no Drush.

- Configuring the condition + config storage → parent doc [../../../../2.2.x/agent/configure/block_visibility_conditions.md](../../../../2.2.x/agent/configure/block_visibility_conditions.md)
- Plugin internals / how to extend the base class → parent doc [../../../../2.2.x/agent/plugins/block_visibility_conditions.md](../../../../2.2.x/agent/plugins/block_visibility_conditions.md)
