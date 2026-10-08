Block Visibility Conditions adds extra block visibility condition plugins to Drupal's core block placement UI, most notably "Not {bundle}" conditions that hide a block on selected content bundles while still showing it everywhere else.

---

Drupal core lets you control where a block appears with visibility conditions (content type, pages, roles, etc.), but its bundle conditions only evaluate on that entity's own pages — a negated "Content type" condition still hides the block on views, taxonomy pages, and the front page because those routes have no node to evaluate against. Block Visibility Conditions solves this by shipping an abstract `NotConditionPluginBase` (a `ConditionPluginBase` subclass) whose "Not" conditions return TRUE (visible) on any page that is *not* a matching bundle page, so the block is only hidden on the chosen bundles and shown on all other pages. The base class removes the "Negate the condition" checkbox and renders a checkboxes list of the entity type's bundles. The parent module itself provides only this base class; concrete conditions are supplied by three optional submodules — Node (`not_node_type`), Taxonomy (`not_taxonomy_vocabulary`), and Commerce (`not_product_type`). Conditions are configured per block in the standard block layout / Layout Builder "Configure block" form and stored in the block's `visibility` config. No admin settings page, permissions, Drush commands, or config schema of its own.

---

- Hide a block on specific node content-type pages while keeping it visible on views, taxonomy, and front pages (use the Node submodule's "Not Node Type").
- Keep a promotional block off Article pages but show it everywhere else without it disappearing from listing pages.
- Hide a sidebar block on selected taxonomy vocabularies' term pages (Taxonomy submodule's "Not Taxonomy Vocabulary").
- Hide a block on Commerce product-type pages while showing it site-wide otherwise (Commerce submodule's "Not Product Type").
- Work around core's negated "Content type" condition hiding a block on non-node pages like views.
- Show a global call-to-action block on the whole site except on a couple of content types.
- Configure the condition directly in the core Block layout "Configure block" form.
- Configure the same condition on a block placed via Layout Builder.
- Select multiple bundles at once — the condition hides the block on any of the checked bundles.
- Combine a "Not" condition with core conditions (roles, pages, request path) on the same block.
- Provide editors a friendly bundle checkbox list instead of writing condition config by hand.
- Export the resulting block visibility settings to config for deployment across environments.
- Extend the module by subclassing `NotConditionPluginBase` for any custom content entity type with bundles.
- Add a "Not" condition for a custom entity type (e.g. media types) via a small custom submodule.
- Restrict a menu or menu-block's appearance away from certain content types without JS or preprocessing.
- Prevent a footer block from showing on product detail pages in a Commerce store.
- Only enable the submodules you need to avoid pulling in node/taxonomy/commerce dependencies unnecessarily.
- Reproduce legacy behavior after upgrading — update hook `9001` auto-enables the node and taxonomy submodules for backward compatibility.
- Build content-type-specific block layouts declaratively in exported block config.
- Reason about visibility precisely: an empty selection means the condition always passes (block shown).
