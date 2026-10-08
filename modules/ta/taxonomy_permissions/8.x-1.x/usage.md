Taxonomy Permissions adds a per-vocabulary "view terms in <vocabulary>" permission that core Taxonomy lacks, so you can control which roles may see terms of each vocabulary instead of relying only on core's blanket term visibility.

---

The module has no configuration UI and no config of its own (`configure: null`); it works entirely through the permissions page and Drupal's entity access system. For every taxonomy vocabulary it dynamically generates one permission, `view terms in <vocabulary_id>` (title "View terms in <label>"), via a `permission_callbacks` entry pointing at `TaxonomyPermissions::permissions`, so the permission list grows and shrinks with your vocabularies. It swaps the taxonomy_term entity's access handler for `TaxonomyPermissionsControlHandler` (extending core's `TermAccessControlHandler`) through `hook_entity_type_alter()`; that handler grants the `view` operation only when the account holds `view terms in <bundle>` and the term is published (holders of `administer taxonomy` always pass), and delegates all other operations (create/update/delete) to core unchanged. A `hook_entity_field_access()` implementation lets a user edit an entity-reference field that targets taxonomy terms when they can view at least one of the field's target vocabularies (or, for view-based reference handlers, when they hold `access taxonomy overview`). To avoid surprising lockouts, `hook_install()` grants every existing vocabulary's view permission to the Anonymous and Authenticated roles, and `hook_entity_insert()` / `hook_entity_delete()` grant or revoke the matching permission for those two roles as vocabularies are created or removed — so by default terms stay visible to everyone until you tighten the permissions. There is no Drush command and no config schema.

---

- Restrict a vocabulary's terms so only editors can view them, while other vocabularies stay public.
- Hide internal/staff-only taxonomy terms from anonymous visitors per vocabulary.
- Give a role read access to terms in some vocabularies but not others.
- Keep a "departments" vocabulary visible only to logged-in staff.
- Expose public "tags" while gating a private "regions" vocabulary behind a role.
- Prevent anonymous users from seeing terms of a moderation/workflow vocabulary.
- Control which roles can pick terms in an entity-reference field by controlling view access to its target vocabulary.
- Let a marketing role view campaign taxonomy terms without granting them "administer taxonomy".
- Scope term visibility per vocabulary using the standard People → Permissions screen.
- Combine with role-based editorial workflows so only reviewers see certain classification terms.
- Ensure unpublished terms are hidden except from users with the vocabulary's view permission.
- Keep term pages (/taxonomy/term/{id}) reachable only by roles holding the vocabulary's view permission.
- Migrate a Drupal 7 site that relied on this module's per-vocabulary view permissions.
- Add granular term visibility without writing a custom access control handler.
- Lock down a taxonomy used for pricing tiers or internal categorization.
- Allow anonymous browsing of a public glossary vocabulary while restricting others.
- Grant a translator role visibility of terms in specific vocabularies for QA.
- Progressively open a new vocabulary to more roles as content is prepared.
- Limit which roles can reference terms of a sensitive vocabulary on content forms.
- Audit per-vocabulary term visibility for each role from one permissions page.
- Keep term listings in views/fields consistent with per-vocabulary view permissions.
- Provide read-only term access to a role that must not administer taxonomy.
