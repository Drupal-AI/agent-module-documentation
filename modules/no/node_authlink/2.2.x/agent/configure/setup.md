# Configure Node Authorize Link

No dedicated settings page (`configure` null). Configuration is added to the **content-type edit
form** (`admin/structure/types/manage/<type>`), in a "Node authorize link" section — visible only
to users with `configure node_authlink module`.

## Per content-type settings (node-type form)
`node_authlink_form_node_type_form_alter()` adds:

| Field | Effect |
|---|---|
| **Enable** | Turns authlinks on for this bundle. Disabling **erases all keys** for the bundle's nodes. |
| **Grants to give** (checkboxes) | Which ops a valid key authorizes: `view`, `view revision`, `update`, `delete`. |
| **Regenerate authkeys after** (select) | Cron rotates keys older than: disabled / 1 day / 1 week / 4 weeks / 3 months / 6 months / 1 year. |
| **Batch: Generate authkeys** | Creates keys for all bundle nodes lacking one (save the form first). |
| **Batch: Delete all authkeys** | Deletes all keys for the bundle (save the form first). |

## Stored config — `node_authlink.settings`
No schema file ships; the config is three keyed maps (bundle → value):

```yaml
enable:  { article: true }
grants:  { article: { view: view, 'view revision': 'view revision', update: 0, delete: 0 } }
expire:  { article: 604800 }   # seconds; 0/'' = never regenerate
```

`grants` values are the operation string when enabled, or `0` when unchecked. `ConfigurationHelper`
reads these (`isBundleEnabled`, `getBundleGrants`).

## Per-node admin form — `/node/{node}/authlink` (tab "Authlink")
Built by `NodeAuthlinkNodeForm` + `NodeFormManager`. Access requires the bundle enabled AND
`create and delete node authlinks` OR `create and delete node <bundle> authlinks`. It:
- shows a **Create authlink** button when the node has no key, else a **Delete authlink** button;
- lists ready-made links for each enabled op (current revision, other revisions, edit, delete),
  each URL carrying `?authkey=<key>`.

## Listing / audit — view `node_authlinks`
Installed from `config/optional` (also (re)created by update 10202). Lists issued keys with a
"Delete Authlink" link (`AuthlinkDeleteLink` views field, gated by the same create/delete perms).
Delete confirm form: `/admin/node/{node}/authlink/delete` (requires `node.delete` entity access).

## Lifecycle
- Key created lazily (`node_authlink_create`) via the per-node form/batch; **not** auto-created on
  node insert.
- `node_authlink_cron()` regenerates keys older than the bundle's `expire`.
- `hook_ENTITY_TYPE_delete`: a node's key is removed when the node is deleted (if bundle enabled).

## Access model & operator notes
- **Token strength:** `hash('sha256', random_bytes(64))` — 256-bit, from a CSPRNG, unique per
  node. Practically **not** guessable or enumerable, so a node cannot be reached by crafting an
  authkey.
- **Scope is admin-controlled:** a link only grants the ops enabled for the bundle; defaults are
  none until an admin ticks grants. Enabling `update`/`delete` deliberately lets an anonymous
  link holder edit/delete that node — intended, but note the **same per-node key** authorizes
  *every* enabled op (there is no separate key per operation).
- **Unpublished/restricted nodes:** a valid key grants the configured op regardless of publish
  status (that is the point of a preview link) — treat any leaked link as full access to that node.
- **Link handling:** the key is passed in the **URL query string** (`?authkey=`), so share links
  through private channels; keys are **permanent by default** (set "Regenerate after" to bound
  how long a link stays valid).
