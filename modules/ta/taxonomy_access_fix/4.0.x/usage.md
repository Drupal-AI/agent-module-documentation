Taxonomy Access Fix extends Drupal Core's Taxonomy access handling with a set of fine-grained, per-vocabulary and "any vocabulary" permissions for viewing, selecting, creating, editing, deleting, reordering and resetting terms — closing gaps where Core only offers "administer taxonomy" or coarse per-vocabulary term editing.

---

The module replaces the access control handlers for `taxonomy_term` and `taxonomy_vocabulary` entities (via `hook_entity_type_alter`) and swaps the default `taxonomy_term` entity-reference selection plugin (via `hook_entity_reference_selection_alter`), so simply enabling or disabling the module switches the extended permission checks on or off with no configuration. It adds separate permissions to view published vs. unpublished term *names* (labels) and term *content*, to select published/unpublished terms in "Default"-method entity reference autocomplete/select widgets, to view vocabulary names, to reorder terms, to reset a vocabulary's term order to alphabetical, and to create/edit/delete terms in *any* vocabulary. Each capability comes in a per-vocabulary form (e.g. `view terms in tags`) and an any-vocabulary form (e.g. `view any term`). Access to a vocabulary's overview page now requires the Core "access the taxonomy vocabulary overview page" permission plus at least one create/edit/delete/reorder/reset permission for that vocabulary, and the vocabulary list and term-overview form are filtered and stripped of controls the user may not use. A `RouteSubscriber` rewires the vocabulary reset-form route to an entity-access check, and a custom reset form redirects to the front page when the user cannot reach the overview page. `administer taxonomy` still bypasses every check. All permissions are surfaced under the "Taxonomy Access Fix" provider (a module cannot register permissions on behalf of Core's Taxonomy module). Because these are security-sensitive access rules, the module guards against unexpected Core/contrib changes by throwing `LogicException` if a foreign access handler or selection plugin is already in use.

---

- Grant a role permission to view published terms in one specific vocabulary without granting "administer taxonomy".
- Grant separate permission to view *unpublished* terms in a vocabulary for moderators.
- Allow viewing a term's *name/label* while withholding access to view the full term page (distinct "view term names" vs "view terms" permissions).
- Hide unpublished term labels from anonymous users while showing published ones.
- Give editors the ability to select terms from a specific vocabulary in an entity-reference autocomplete widget, without site-wide taxonomy admin rights.
- Restrict which vocabularies appear as selectable options in a "Default"-method entity reference field, per role.
- Let a role select unpublished terms in reference fields for curation workflows.
- Grant "create any term", "update any term" or "delete any term" across all vocabularies in one permission instead of per-vocabulary.
- Allow a role to reorder (drag-and-drop weight) terms in a single vocabulary while blocking edits to term content.
- Grant "reorder terms in any vocabulary" to a content-structure manager role.
- Allow a role to reset a vocabulary's term order to alphabetical via the reset form.
- Provide "reset any vocabulary" to a cleanup/maintenance role.
- Expose the vocabulary overview page to a role that can only reorder or reset terms, without full admin access.
- Show only the vocabularies a user can act on by filtering the vocabulary collection list per their permissions.
- Remove the drag-and-drop weight column and Save button from the term overview for users who lack reorder permission.
- Grant permission to view a vocabulary's name ("view vocabulary name of <vid>") independently of term access.
- Provide an "any vocabulary" view-name permission for building cross-vocabulary term listings.
- Build a public glossary where anonymous users may view published term names but not edit or reorder them.
- Enforce field-level access so term labels rendered in referencing entities respect view-name permissions.
- Migrate Drupal 7 taxonomy permissions: automatically add reorder/view/view-unpublished permissions for every D7 "add terms in <vocab>" permission during `d7_user_role` migration.
- Differentiate front-end term viewers from back-end term editors with non-overlapping permission sets.
- Prevent editors who can select terms in a widget from being able to open or edit those term pages.
- Redirect users who reset a vocabulary but lack overview access back to the front page (or a supplied `destination`).
- Lock down a taxonomy-driven access or tagging system so each role sees only the vocabularies relevant to it.
- Audit and tighten an existing site by replacing the all-or-nothing "administer taxonomy" grant with least-privilege per-vocabulary permissions.
