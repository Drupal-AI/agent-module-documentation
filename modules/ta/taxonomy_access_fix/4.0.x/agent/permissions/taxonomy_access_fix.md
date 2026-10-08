# Permissions

Defined dynamically in `TaxonomyAccessFixPermissions::getPermissions()` (registered via
`taxonomy_access_fix.permissions.yml` `permission_callbacks`). Listed under the
**Taxonomy Access Fix** provider on `/admin/people/permissions` (a module cannot add
permissions on Core Taxonomy's behalf). Per-vocabulary permissions are also editable on a
vocabulary's *Manage permissions* tab. `administer taxonomy` (Core) bypasses all of them.

`<vid>` below is a vocabulary machine name, e.g. `tags`.

## "Any vocabulary" permissions (apply to every vocabulary)

| Permission | Grants |
|---|---|
| `view any term` | View any published term (full term / `view` op). |
| `view any unpublished term` | View any unpublished term. |
| `view any term name` | View the label of any published term (`view label` op). |
| `view any unpublished term name` | View the label of any unpublished term. |
| `view any vocabulary name` | View the label of any vocabulary. |
| `create any term` | Create terms in any vocabulary. |
| `update any term` | Edit terms in any vocabulary. |
| `delete any term` | Delete terms in any vocabulary. |
| `reorder terms in any vocabulary` | Change term order (weights) in any vocabulary. |
| `reset any vocabulary` | Reset any vocabulary's term order to alphabetical. |
| `select any term` | Select published terms in any vocabulary in "Default"-method entity reference widgets. |
| `select any unpublished term` | Select unpublished terms in any vocabulary in such widgets. |

## Per-vocabulary permissions (one set generated per vocabulary)

| Permission (per `<vid>`) | Grants |
|---|---|
| `view terms in <vid>` | View published terms in that vocabulary (`view` op). |
| `view unpublished terms in <vid>` | View unpublished terms in that vocabulary. |
| `view term names in <vid>` | View published term labels (`view label` op). |
| `view unpublished term names in <vid>` | View unpublished term labels. |
| `view vocabulary name of <vid>` | View that vocabulary's label. |
| `reorder terms in <vid>` | Reorder (weight) terms in that vocabulary. |
| `reset <vid>` | Access that vocabulary's reset-to-alphabetical form. |
| `select terms in <vid>` | Select published terms of that vocabulary in "Default"-method reference widgets. |
| `select unpublished terms in <vid>` | Select unpublished terms of that vocabulary in such widgets. |

## Key semantics

- **Name vs. term are separate.** "view terms" (`view` op) does NOT grant the label;
  viewing a label needs a "view (…) term names" permission (`view label` op). A field
  formatter rendering a term label checks the name permission, not the term permission.
- **Published vs. unpublished are separate** for both view and select. Published grants do
  not cover unpublished terms; those need the explicit `unpublished` variants (or
  `administer taxonomy`).
- **Select** only affects entity reference fields using the **Default** reference method.
  A user who can `select` a term sees its label in autocomplete results even without any
  "view name" permission. Selection is enforced both in the option list and on submit
  (`validateReferenceableNewEntities`).
- **create / update / delete** per vocabulary are Core permissions
  (`create terms in <vid>`, `edit terms in <vid>`, `delete terms in <vid>`); this module
  only adds the `… any term` counterparts (and the `update` op maps to Core's `edit`).
- **Vocabulary overview page** (`/admin/structure/taxonomy/manage/<vid>/overview`) requires
  the Core `access the taxonomy vocabulary overview page` permission AND at least one of:
  `create/delete/edit terms in <vid>`, `create any term`/`delete any term`/`update any term`,
  `reorder terms in <vid>`/`reorder terms in any vocabulary`, `reset <vid>`/`reset any vocabulary`.
- **Reorder ≠ reset.** Reorder permission shows drag-and-drop weights + Save; reset
  permission shows the "Reset to alphabetical" action. Each is independent.
- Forbidden access results carry a human-readable reason listing the permissions that would
  have allowed the operation (plus `administer taxonomy`).
