# Settings

Form `SettingsForm` at route `override_node_options.settings`
(`/admin/config/content/override-node-options`; requires `administer site configuration`). It
just decides **which sets of permissions are generated** (config
`override_node_options.settings`):

| Key | Default | Effect |
|---|---|---|
| `general_permissions` | `true` | Generate the "…all…" permissions that apply across every content type |
| `specific_permissions` | `true` | Generate one permission set per node type (e.g. `override article published option`) |

Turning a set off removes those permissions from the permissions page (and any grants become
inert). After changing, assign the permissions at
`/admin/people/permissions#module-override_node_options` — see
[../permissions/permissions.md](../permissions/permissions.md).

There is no other configuration; all behavior is driven by the permissions a role holds.
