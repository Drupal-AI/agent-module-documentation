# Permissions

From `antibot.permissions.yml`:

| Permission | Gates | Notes |
|---|---|---|
| `administer antibot configuration` | Access to the settings form (`/admin/config/user-interface/antibot`). | `restrict access: true` — treat as trusted/admin only. |
| `skip antibot` | Users with this permission bypass Antibot entirely (their forms are not protected). | Grant to trusted roles; keep off anonymous. |
