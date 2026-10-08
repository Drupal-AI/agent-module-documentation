<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Permissions by Entity is the submodule of Permissions by Term that applies the same user/role→taxonomy-term grants to **non-node fieldable entities** — media, paragraphs, block content, custom entities — that reference a restricted term.

---

It adds no configuration, no permissions and no schema of its own: it reuses `permissions_by_term.settings` and the `permissions_by_term_user` / `permissions_by_term_role` tables. Its `AccessChecker` extends `Drupal\permissions_by_term\Service\AccessCheck` and adds two methods — `isAccessControlled()` (does this entity reference a term that is under control?) and `isAccessAllowed()` (may this uid see it?) — both of which walk the entity's fields, follow entity-reference fields **recursively** into other fieldable entities, and use a `CheckedEntityCache` to break circular references. Enforcement happens in two places: `hook_entity_access()` returns `AccessResult::forbidden()` for `view` on any non-node fieldable entity that is access-controlled and not allowed (results cached per uid/entity with the tag `permissions_by_entity:access_result_cache:<type>:<id>`), and a kernel `REQUEST` subscriber (priority 28, deliberately **before** `DynamicPageCacheSubscriber`) throws `AccessDeniedHttpException` for the routed entity. Nodes are explicitly excluded — `isAccessControlled()` returns `FALSE` for them so the parent module keeps ownership. **The critical prerequisite:** `permissions_by_term.settings:target_bundles` must be non-empty *and* intersect the taxonomy field's own `handler_settings.target_bundles`; with the default empty `target_bundles` the submodule never controls anything. Denials on a referenced entity dispatch `permissions_by_entity.entity_field_value_access_denied_event`, and the bundled `RemoveEntityFromViewEventSubscriber` uses it to strip inaccessible referenced entities out of the rendered field.

---

- Hide media items tagged with a restricted term from users without that term.
- Restrict paragraphs inside a page so each department only sees its own paragraph.
- Protect custom block content by taxonomy term.
- Apply the same "department" term rules to media that already protect nodes.
- Remove inaccessible referenced entities from a rendered entity-reference field instead of showing an empty teaser.
- Protect a custom entity type that has a taxonomy term reference field.
- Keep term-based restrictions working on entity canonical routes (`/media/5`) via the kernel subscriber.
- Ensure restricted entities are not served from the dynamic page cache to the wrong user.
- Combine node restrictions (parent module) and media restrictions (this submodule) with one grant table.
- Cache access results per user and entity with a dedicated invalidation tag.
- React to a denied referenced entity with a subscriber on the entity-field-value-denied event.
- Recursively evaluate nested paragraphs without hitting a circular-reference loop.
- Enforce "user must hold all terms" semantics on entities as well as nodes (`require_all_terms_granted`).
- Make every taxonomy-referencing entity restricted by default with `permission_mode`.
- Limit the whole mechanism to selected vocabularies through `target_bundles`.
- Protect a media library so contributors only see their client's assets.
- Restrict a "contract" custom entity to the account it belongs to via a term.
- Give an intranet's media assets the same visibility model as its documents.
- Invalidate an entity's access cache automatically when it is created or updated.
- Debug why an entity is (not) restricted by calling `isAccessControlled()` from a Drush eval.
- Audit which non-node entities are under term control before a launch.
- Migrate custom `hook_entity_access()` code onto configuration-driven term grants.
- Keep restricted media out of a rendered node without writing a custom field formatter.
