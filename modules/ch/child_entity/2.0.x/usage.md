<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Child Entity is a developer toolkit (a trait plus route/access/permission providers) for building content entity types that are always owned by a parent entity.
---
The module solves the recurring need for "sub entities" — content entities that only exist in the context of a parent (similar to how paragraphs attach to a host). A developer makes a custom entity implement `ChildEntityInterface`, uses `ChildEntityTrait`, adds a `parent` entity key, and wires up the provided handlers: `ChildContentEntityHtmlRouteProvider` nests all entity routes beneath the parent's canonical/edit path, `ChildEntityRouteContext` exposes the parent as a context provider, `ChildEntityController::addPage` builds the add page with the parent bound from the route, and `ChildEntityPermissions` generates per-type and per-bundle create/edit/delete/revision permissions.

Access is handled by `ChildEntityAccessControlHandler`: for `view` it allows published entities (or non-view operations) and then AND-combines the result with the parent entity's access for the same operation, i.e. a child inherits its parent's access. Note two behaviors worth understanding before relying on it: the generated create/edit/delete permissions are declared but `checkAccess()` gates edit/delete purely on parent access (plus published status for view), and `checkCreateAccess()` returns "allowed" for any HTML-format request rather than checking the create permission or parent access. Review these against your threat model when exposing child-entity forms.

Typical setup is entirely in code: define the entity type with the trait, the `parent` key, the route provider, the access handler, and the permission callback, then rebuild caches.
---
- Model content entities that belong to a specific parent entity.
- Nest child entity routes under the parent's canonical or edit URL automatically.
- Provide the parent entity to blocks/plugins via a route context provider.
- Generate an add page that binds the parent from the current route.
- Auto-redirect to the add form when a child type has a single bundle.
- Generate per-entity-type create/edit/delete permissions.
- Generate per-bundle create/edit/delete permissions.
- Generate revision view/revert/delete permissions for RevisionLog child types.
- Make a child inherit its parent's access (AND-combined per operation).
- Restrict child view access to published items for publishable entity types.
- Add a read-only `parent` entity_reference base field via the trait.
- Support multi-level nesting (child of a child of a parent).
- Build hierarchical data structures (e.g. committees → meetings → agenda items).
- Integrate with views_add_button for context-aware "add child" buttons.
- Provide Views data for child entities via `ChildEntityViewsData`.
- Reuse core EntityController/AdminHtmlRouteProvider behavior with parent awareness.
- Enforce that child entity types declare a `parent` key (throws otherwise).
- Prototype paragraph-like ownership without the Paragraphs module.
