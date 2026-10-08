<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Bundle provides a generic, "un-opinionated" content entity type (`field_bundle`) whose bundles are defined by the site builder. It is a neutral container for arbitrary sets of fields — useful when you need reusable structured data that is not a node, taxonomy term, or paragraph, but still want revisions, translations, and a full access-control/permission model.

Bundles are managed as `field_bundle_config` configuration entities. Optional submodules add canonical URLs and Group (group content enabler) integration.

---

- Requires core `user`; Drupal 9.2+ or 10.
- Enable with `drush en field_bundle`.
- Manage bundle types at `admin/structure/field-bundle` (config route `entity.field_bundle_config.collection`).
- Add fields to a bundle via the standard Field UI, then create field_bundle entities from the overview.
- Grant per-operation permissions (create/view/update/delete, own/any, revisions) defined in `field_bundle.permissions.yml` and the `FieldBundlePermissions` callback.
- Optional submodules: `field_bundle_canonical` (canonical page/URL) and `group_field_bundle` (Group integration).

---

- Model arbitrary structured data as a first-class entity type.
- Create multiple bundles, each with its own field set.
- Attach any Drupal field type via Field UI.
- Get full revision history with revert/delete revision UI.
- Translate field bundle content (translation controller included).
- Enforce granular create/view/update/delete permissions (own vs any).
- Restrict access to unpublished bundles ("view any" vs "view own").
- Use query access handling for entity/view integration.
- Reference field bundles from other entities.
- Provide canonical URLs via the canonical submodule.
- Add field bundles as Group content via the group submodule.
- Use tokens for field bundle values (`field_bundle.tokens.inc`).
- Build lightweight custom data types without a custom module.
- Keep data separate from nodes for cleaner content modeling.
- Administer bundle configuration with a dedicated permission.
- Serve as an alternative to Paragraphs/ECK for standalone entities.
