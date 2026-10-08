<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
View Unpublished Dynamic Permission generates a "view any unpublished" permission for every publishable entity type (and per bundle) and grants view access to unpublished entities only to holders of the matching permission.
---
The module iterates all entity types implementing `EntityPublishedInterface` and, via a permission callback, generates a per-entity-type permission `view any unpublished <entity_type>` plus, for bundleable types, a per-bundle `view any unpublished <entity_type>:<bundle>`. Its `hook_entity_access` implementation (`ViewUnpublishedDynamicPermissionHooks::entityAccess`) fires only for the `view` operation on an unpublished `EntityPublishedInterface` entity: if the account holds either the bundle-level or entity-type-level permission it returns `AccessResult::allowed()` (cache-per-permissions); otherwise it returns `AccessResult::forbidden()`. For published entities or other operations it returns neutral.

Because the check returns *forbidden* rather than neutral when the permission is absent, an unauthorised user is explicitly denied view access to unpublished content — access is never widened beyond permission holders. Note that a `forbidden` result is authoritative in Drupal's access system and can override an `allowed` from another module (e.g. an author viewing their own unpublished node), so grant the relevant permission to any role that should retain such access.

There is no configuration UI beyond `/admin/people/permissions`: install the module, then assign the generated "View any unpublished …" permissions to the roles (proofreaders, editors, etc.) that should see unpublished entities of a given type or bundle.

---

- Grant a role permission to view any unpublished content of a type
- Grant per-bundle 'view any unpublished' permissions (e.g. per node type)
- Let proofreaders view unpublished nodes without owning them
- Expose 'view any unpublished' permissions for every publishable entity type
- Assign the generated permissions at /admin/people/permissions
- Allow editors to preview unpublished media or custom entities
- Deny unpublished view access to users lacking the permission (forbidden)
- Control unpublished access at the entity-type level
- Control unpublished access at the bundle level
- Avoid custom code for a simple 'view any unpublished' requirement
- Cache access decisions per permissions/per user for correctness
- Give content checkers read access without creating unique URLs
- Complement moderation workflows needing broad unpublished visibility
- Restrict unpublished visibility to trusted roles only
- Apply consistently across all EntityPublishedInterface entities
- Grant the permission to author roles so they retain own-content access
