# paragraphs_edit — access & permissions

Paragraphs Edit **defines no permissions of its own** — there is no
`paragraphs_edit.permissions.yml` (`provides_permissions: false`). Access to the
per-paragraph edit/clone/delete routes is enforced entirely by **core entity access**
checks declared on the routes (`_entity_access`):

| Route | Requirement | Meaning |
|---|---|---|
| `paragraphs_edit.edit_form` | `root_parent.update` | user must have **update** access to the top host entity (the root parent) |
| `paragraphs_edit.delete_form` | `root_parent.update` | same — update access to the root parent host entity |
| `paragraphs_edit.clone_form` | `paragraph.update` | user must have **update** access to the paragraph itself |

So whoever can edit the host entity (e.g. `edit any article content`, or node-level access
from other modules) can edit/delete its paragraphs; cloning keys off the paragraph's own
update access. The clone form additionally validates at submit time that the user has
`update` access on the chosen **destination** entity and `edit` access on the chosen
**destination field**.

If you need finer-grained, per-paragraph-type control, that comes from other modules (e.g.
the Paragraphs `paragraphs_type_permissions` submodule) — Paragraphs Edit does not add it.
The `contextual` dependency also means links are only visible to users with the core
**Use contextual links** (`access contextual links`) permission.
