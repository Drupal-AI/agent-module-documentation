# Geysir permissions

Defined in `geysir.permissions.yml` — a single permission:

| Permission | Machine name | `restrict access` |
|---|---|---|
| Manage Paragraphs from the front-end | `geysir manage paragraphs from front-end` | *not set* (default FALSE) |

## What it gates

Holding this permission is the sole route requirement for every Geysir action route
(`geysir.routing.yml`): `geysir.modal.edit_form`, `geysir.modal.delete_form`,
`geysir.modal.add_form`, `geysir.modal.add_form_first`, `geysir.modal.translate_form`,
`geysir.cut`, `geysir.paste`, and the non-modal `geysir.edit_form` / `geysir.delete_form`.

Through those routes the holder can add, edit, delete, cut, paste and translate Paragraphs on
a parent entity, each save creating a new revision of that parent entity.

## Button visibility vs. route access (important)

The action buttons are only rendered (`geysir_preprocess_field()` / `geysir_preprocess_node()`)
when ALL of these hold for the current node:

- the user has `geysir manage paragraphs from front-end`,
- `$node->access('update')` is TRUE,
- the node is the latest revision, and (for add/cut/paste) the parent is not a non-default
  translation.

The `/geysir/...` routes themselves require the flat permission. Grant it to roles you trust to
edit paragraph content, and prefer to keep it on the same roles that already hold the relevant
node update permissions.
