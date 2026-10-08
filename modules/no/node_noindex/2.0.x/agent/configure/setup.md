<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Node Noindex

There is **no** module settings page (`configure` is null; no admin route). Configuration is
per content type plus a per-node checkbox.

## Step 1 — enable the field on a content type

Edit the content type (*Structure → Content types → <type> → Edit*, i.e.
`/admin/structure/types/manage/<bundle>`, gated by `administer content types`). The module's
`hook_form_node_type_form_alter()` adds a **Node Noindex settings** vertical tab with:

| Setting | Third-party key | Effect |
|---|---|---|
| Show the 'Exclude from search engines' field | `noindex` | When on, the per-node checkbox appears on nodes of this bundle. |
| The default value for the 'Exclude from search engines' field | `noindex_default` | Default the per-node checkbox takes on **new** nodes (only visible/editable when the field is shown). |

An entity builder (`node_noindex_form_node_type_form_builder`) writes both into
`node.type.<bundle>.third_party.node_noindex` (schema: `config/schema/node_noindex.schema.yml`).

## Step 2 — set it per node

On the node add/edit form, the **Exclude from search engines** checkbox appears inside a
**Search engine settings** group (in the `advanced` sidebar). It is shown only when **both**
hold:

1. the bundle has the field enabled (Step 1), and
2. the current user has the **`mark content as not indexable`** permission.

The group opens automatically if the node is already flagged. The value is stored on the node
as the boolean base field `noindex` (translatable, revisionable) — not in config.

## What gets emitted

On the node's rendered page, `hook_preprocess_html()` appends to `html_head`:

```html
<meta name="robots" content="noindex">
```

The `content` value is a hard-coded literal `noindex` — nothing from user input is
interpolated. The tag is added on any route carrying a `node` parameter whose `noindex`
value is truthy (canonical view and other node-param routes), keyed `node_noindex_noindex`.

## Permissions summary

- `mark content as not indexable` — gates only the per-node checkbox.
- Enabling/disabling the field per content type rides on `administer content types`.

## Notes for agents

- Setting exists but no checkbox on the node form → the bundle has not been enabled (Step 1)
  or the user lacks `mark content as not indexable`.
- The flag is a base field, so it is per-node (and per-translation/revision), not a global
  list of node IDs and not a metatag config entity.
