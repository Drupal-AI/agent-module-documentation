<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Type Access Conditions lets you restrict operations (create/view/update/delete) on entity types and their bundles using the reusable condition plugins provided by the Conditions Helper module.

---

The module adds an "Entity Type Access Conditions" section to the configuration forms of supported bundles (out of the box: Node types, Media types, Taxonomy vocabularies) where an admin builds a set of conditions using Conditions Helper (which wraps core Condition plugins and available contexts). Conditions are stored in the bundle's `third_party_settings`. At runtime it implements `hook_entity_access`, `hook_entity_create_access` and `hook_entity_type_access_conditions_form_ids_alter`: for a restricted operation it evaluates the stored conditions and returns `AccessResult::forbidden()` when they are NOT met, otherwise it returns neutral (deferring to core/other modules) — it never grants access on its own, so it is a purely additive restriction layer. Which operations are restricted per entity type is declared by a YAML plugin (`*.entity_type_access_conditions.yml`); the shipped defaults restrict `create` on node/media/taxonomy_term content entities and `create`/`update`/`delete`/`view`(config) plus `access taxonomy overview` on the corresponding bundle config entities. Two `restrict access: true` permissions gate the feature: `administer entity type access conditions` (choose which conditions are available) and `bypass entity type access conditions` (always pass). Developers extend it to new entity types by shipping their own YAML plugin file and optionally altering the form-id list via the provided hook.

---

- Restrict who can create nodes of a given content type based on the current user's role.
- Only allow creating a certain content type on specific domains (via a domain context/condition).
- Limit media creation of a bundle to a request/context condition (e.g. time, path, language).
- Restrict access to a taxonomy vocabulary's overview page under configurable conditions.
- Forbid updating or deleting a specific node type's config unless conditions are met.
- Apply role- or context-based rules without writing a custom access hook.
- Add access conditions to a custom entity type by shipping a `*.entity_type_access_conditions.yml` file.
- Reuse any Conditions Helper / core Condition plugin (request path, user role, language, etc.).
- Combine multiple conditions on one bundle (all evaluated together by Conditions Helper).
- Grant a support/admin role the `bypass entity type access conditions` permission to skip all checks.
- Centralize bundle-creation rules in config instead of scattered permission grants.
- Restrict node creation forms so unauthorized users cannot reach the add form (create access).
- Curate which condition plugins editors may choose from via the admin settings page.
- Gate media type creation to authenticated users meeting a context condition.
- Enforce environment-specific content rules (e.g. only create certain types on staging).
- Add support for another entity type's forms dynamically using the `_form_ids_alter` hook.
- Layer condition-based restrictions on top of core permissions without replacing them.
- Prevent creation of restricted bundles while leaving viewing existing content unaffected (per the default operation map).
- Store the access rules in exportable configuration for deployment across environments.
- Provide business-rule-style access gating (workflow-like) using conditions and contexts.
