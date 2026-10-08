URL Alias Permissions adds granular permissions that let you grant editing of the URL alias (`path`) field per entity type — or per bundle for bundle-granular entity types like nodes — instead of the single global "create url aliases" permission.

---

Out of the box Drupal exposes the path/URL-alias field on entity forms only to users with the
core `create url aliases` (or `administer url aliases`) permission, which is all-or-nothing. This
module implements `hook_entity_field_access` for the `path` field type on the `edit` operation and
grants access when the account holds a dynamically generated per-type/per-bundle permission. It
provides a permission callback (`UrlAliasPermPermissions::urlAliasPermissions`) that walks every
entity type with a `path` field and emits, for bundle-granular types, `edit <bundle> <entity_type>
url alias` (e.g. `edit page node url alias`) and for entity-type-granular types `edit <entity_type>
url alias`. Field-edit access is then allowed if the user has that specific permission **OR** the
core `create url aliases` **OR** `administer url aliases`. The module only ever *grants* access
(it returns `AccessResult::allowed()` on match and `neutral` otherwise), so it loosens the core
gate for the roles you choose rather than adding new denials. There is no configuration UI
(`configure` is null); you assign the generated permissions on the standard People → Permissions
page. An update hook (`update_8001`) migrated older `edit <type> url alias` node permissions to
the current `edit <type> node url alias` naming.

---

- Let a specific role edit the URL alias only on Article nodes, not on other content types.
- Allow editors to set the path alias on Pages while Pathauto silently manages Blog paths.
- Hide the URL alias field from users for a content type where custom paths are unwanted.
- Grant alias editing per entity type (e.g. taxonomy terms, media) rather than site-wide.
- Replace the coarse core `create url aliases` permission with per-bundle control.
- Give a "webmaster" role alias control over landing-page content types but not articles.
- Combine with Pathauto so most content auto-aliases while a few types allow manual overrides.
- Permit alias editing on custom entity types that use entity-type permission granularity.
- Keep the standard core permissions (`create url aliases` / `administer url aliases`) working as
  overrides that still grant access everywhere.
- Delegate alias management for one section of the site to a team without giving global alias rights.
- Prevent content authors from changing SEO-critical aliases on automatically-pathed content types.
- Expose the path field on forms only for the bundles a role is explicitly trusted with.
- Support any entity type that attaches a `path` field, not just nodes.
- Assign alias permissions through the normal Permissions UI with no extra configuration.
- Audit which roles can edit aliases for which content types from the permissions matrix.
