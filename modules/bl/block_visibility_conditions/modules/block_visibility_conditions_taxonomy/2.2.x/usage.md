Submodule of Block Visibility Conditions that provides the "Not Taxonomy Vocabulary" (`not_taxonomy_vocabulary`) block visibility condition, hiding a block on selected taxonomy vocabularies' term pages while keeping it visible elsewhere.

---

This submodule ships a single concrete condition plugin, `NotTaxonomyVocabulary` (id `not_taxonomy_vocabulary`, label "Not Taxonomy Vocabulary"), which extends the parent module's `NotConditionPluginBase` with `CONTENT_ENTITY_TYPE = 'taxonomy_vocabulary'`. In the core Block layout or Layout Builder "Configure block" form it renders a checkboxes list of vocabularies; the block is hidden only on term pages of the checked vocabularies and shown everywhere else, unlike core's negated "Taxonomy vocabulary" condition which disappears on non-term routes. Its `*.info.yml` declares only `drupal:taxonomy` as a dependency (it relies on the parent's base class being present but does not list the parent module explicitly). No settings page, permissions, Drush commands, or config schema. Update hook `9001` in the parent auto-enables this submodule for backward compatibility.

---

- Hide a sidebar block on term pages of a specific vocabulary while showing it site-wide.
- Keep a block off Tags term pages but visible on nodes and views.
- Select multiple vocabularies at once to hide a block on any of their term pages.
- Replace a core negated "Taxonomy vocabulary" condition that wrongly hides a block on other pages.
- Configure the condition per block in Block layout without editing config by hand.
- Apply the condition to a block placed via Layout Builder.
- Show a related-content block everywhere except on a chosen vocabulary's term pages.
- Export the block's visibility config for deployment across environments.
- Combine "Not Taxonomy Vocabulary" with core role/path conditions on one block.
- Preserve legacy behavior after upgrading via the auto-enable update hook.
- Give editors a friendly vocabulary checkbox list for block visibility.
- Enable only this submodule when you need taxonomy-based conditions but not node or commerce.
- Reason precisely: an empty vocabulary selection means the block is always shown.
- Hide a promotional block on category term pages only.
- Restrict a menu block from appearing on specific vocabularies' term pages.
