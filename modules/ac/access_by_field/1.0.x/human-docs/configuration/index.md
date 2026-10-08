# Configuration

Configuration means creating one or more **field mappings** — each one pairs a
field on an entity with a field on the user, and tells the module which operations
to restrict. You also choose which roles bypass the whole system.

## 0. Prepare the fields to compare

Before mapping, make sure you have two comparable fields:

- A field on the **entity** (a node type or a taxonomy vocabulary), and
- A field on the **user** account,

both of the **same type** — either `entity_reference` (pointing at a target
bundle) or `boolean`. Only reference/boolean fields with a target bundle are
offered when you build a mapping. The module compares the referenced item IDs
(`target_id`) on each side.

## 1. Reach the configuration menu

Go to **`/admin/config/access-by-field`**. From here you can add mappings, open
the mapping dashboard, and set bypass roles. All of these pages require the
`access abf mapping settings page` permission.

## 2. Add a field mapping

Add a mapping for a given entity type and bundle at
`/admin/config/access-by-field/fields-mapping/{type}/{bundle}`. On this form you:

- Select the **entity field** to compare.
- Select the **user field** to compare it against.
- Choose the **operations to restrict** — any of `create`, `view`, `update`, and
  `delete`.

How the decision then works:

- For **view**, access is allowed only if the user and the entity share at least
  one `target_id` value.
- For **update** and **delete**, the module *additionally* requires the matching
  core permission (for example `update any/own X content`, or `delete terms in X`)
  — the field match alone is not enough.
- A bundle that has **no** mapping is left completely alone — no restriction is
  added to it.

## 3. Set bypass roles

At `/admin/config/access-by-field/bypass-role`, choose the roles that should
**bypass all restrictions** — users in a bypass role always pass the check. The
**administrator** role bypasses by default when no bypass configuration exists
yet, so administrators are not locked out before you have configured anything.

## 4. Review everything on the dashboard

The **Mapping Dashboard** at `/admin/config/access-by-field/mapping-list` lists
every mapping with its label, entity type, bundle, the two fields, and the
operations it revokes. You can delete a mapping through a confirmation form at
`.../{bundle}/delete`.

## Important correctness note

The module returns its access results **without per-user cache metadata**. That
means you must pair it with appropriate cache settings so that page and render
caching do not serve one user's allowed/blocked result to another user. Always
**test each mapping as a non-privileged (non-bypass) user** before relying on it,
and remember a "forbidden" result here overrides other modules' "allowed"
results. Treat this as coarse, field-driven segmentation rather than fine-grained
access control.
