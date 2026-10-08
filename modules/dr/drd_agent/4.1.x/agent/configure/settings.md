<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & State

DRD Agent stores everything in **State**, not config — there is no config object or schema.

## Settings form

*Configuration → System → DRD Agent* (`/admin/config/system/drd`, route
`drd_agent.settings.form`, permission `administer site configuration`). The form has exactly one
field:

- **Debug mode** → State key `drd_agent.debug_mode` (boolean, default FALSE).

```bash
drush state:get drd_agent.debug_mode
drush state:set drd_agent.debug_mode 1
```

## State keys the module manages

| State key | Meaning |
|---|---|
| `drd_agent.debug_mode` | Debug toggle from the settings form. |
| `drd_agent.authorised` | Array of DRD dashboards authorized to control this site (written by the authorize handshake). |
| `drd_agent.ott` | One-time token used during authorization. |

(Prior to 4.x these lived in a `drd_agent.settings` config object; `drd_agent_update_8001`
migrated them to State — do not expect config.)

## Authorizing a dashboard

A DRD portal connects by calling the agent's authorize routes (`/drd-agent-authorize`,
`/drd-agent-authorize-secret`) or you run the Drush setup command with a token from the portal
(see [../drush/commands.md](../drush/commands.md)). Successful authorization appends the
dashboard's credentials to `drd_agent.authorised`. Requests are encrypted (OpenSSL/TLS) and
authenticated (shared secret or username/password).
