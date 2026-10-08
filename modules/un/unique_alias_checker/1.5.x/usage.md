<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Unique Alias Checker adds a form validator to node and taxonomy term forms that errors out when Pathauto would produce a URL alias identical to one already in use.
---
Pathauto silently de-duplicates colliding aliases by appending a numeric suffix (e.g. `-0`), which can quietly produce unexpected URLs for content editors. This module catches that situation *before* save: `hook_form_node_form_alter()` and `hook_form_taxonomy_term_form_alter()` append `unique_alias_checker_validate()` to the form's `#validate` array (only for `default`, `edit`, and `quick_node_clone` operations). The validator runs only when the entity's "Generate automatic URL alias" (`path[0][pathauto]`) checkbox is checked, builds the prospective entity from form state, and calls the `unique_alias_checker` service's `checkAlias()` to compute the alias Pathauto *would* generate and test whether it already exists.

If a duplicate would be created, validation fails with a configurable message (`error_msg`), forcing the editor to change the content so a distinct alias is produced. Bundles can be excluded from the check via the `exclude_bundles` setting on the admin form at `/admin/config/unique_alias_checker/unique_alias_checker_settings` (gated by the Pathauto `Administer pathauto` permission). The module depends on Pathauto and reuses its alias cleaner, storage helper, and uniquifier services; it has no routes beyond the settings form and performs no external calls, so its security posture is simply that of an admin-permission-gated settings form plus an entity-form validator.
---
- Prevent editors from unknowingly creating duplicate URL aliases on node save
- Prevent duplicate aliases on taxonomy term save
- Show a clear validation error instead of silent Pathauto suffixing
- Customize the error message shown on a detected duplicate (`error_msg`)
- Exclude specific node bundles from the uniqueness check
- Exclude specific taxonomy vocabularies (bundles) from the check
- Support Quick Node Clone by validating the `quick_node_clone` form operation
- Only enforce the check when "Generate automatic URL alias" is enabled on the entity
- Skip the check when an editor supplies a manual alias
- Configure behavior at `/admin/config/unique_alias_checker/unique_alias_checker_settings`
- Restrict configuration access to holders of the `Administer pathauto` permission
- Reuse Pathauto's alias cleaner/uniquifier to compute the prospective alias accurately
- Audit which bundles are currently excluded via the settings form
- Enforce unique aliases as part of an editorial content-quality workflow
- Combine with Pathauto patterns to guarantee predictable, collision-free URLs
- Catch alias collisions caused by identical titles across content
- Keep SEO-friendly URLs stable by refusing accidental `-0`/`-1` suffixes
