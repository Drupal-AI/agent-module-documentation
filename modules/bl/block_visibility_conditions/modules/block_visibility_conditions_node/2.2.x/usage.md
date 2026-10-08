Submodule of Block Visibility Conditions that provides the "Not Node Type" (`not_node_type`) block visibility condition, hiding a block on selected node content types while keeping it visible on all other pages.

---

This submodule ships a single concrete condition plugin, `NotNodeType` (id `not_node_type`, label "Not Node Type"), which extends the parent module's `NotConditionPluginBase` with `CONTENT_ENTITY_TYPE = 'node_type'`. In the core Block layout or Layout Builder "Configure block" form it renders a checkboxes list of node content types; the block is hidden only on the checked content types' node pages and shown everywhere else (views, taxonomy, front page), unlike core's negated "Content type" condition which disappears on non-node routes. It depends on the parent module and Drupal's node module. No settings page, permissions, Drush commands, or config schema. Historically its condition lived in the parent module; update hook `9001` auto-enables this submodule for backward compatibility.

---

- Hide a promotional block on Article pages but keep it on views and the front page.
- Keep a sidebar block off selected content types while showing it site-wide.
- Select multiple content types at once to hide a block on any of them.
- Replace a core negated "Content type" condition that wrongly hides a block on listing pages.
- Configure the condition per block in Block layout without writing config by hand.
- Apply the same condition to a block placed via Layout Builder.
- Show a call-to-action block everywhere except on a couple of node types.
- Export the block's visibility config for deployment across environments.
- Combine "Not Node Type" with core role/path conditions on one block.
- Preserve legacy behavior after upgrading via the auto-enable update hook.
- Hide a footer block on long-form content types only.
- Give editors a friendly content-type checkbox list for block visibility.
- Enable only this submodule when you need node-based conditions but not taxonomy or commerce.
- Reason precisely: an empty content-type selection means the block is always shown.
- Restrict a menu block from appearing on specific content-type pages.
