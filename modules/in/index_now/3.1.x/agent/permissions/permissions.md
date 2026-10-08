# index_now — permissions

Two permissions (`index_now.permissions.yml`):

| Permission | Gates |
|---|---|
| `configure index now` | Access the settings form at `/admin/config/services/index_now` (engine choice, per-type excludes, async/verbose/cli modes, key generation). `restrict access: true`. |
| `view index now submission results` | Whether the user sees on-screen `messenger` messages when a URL is submitted or when the engine returns an error/warning. Purely informational — does not affect whether pings are sent. In CLI context messages show regardless of this permission. |

The public key-file route (`index_now.api_key`, `/index_now_api_key_{key}.txt`) is intentionally
open to anonymous (`_access: 'TRUE'`) because search engines must fetch the key file — see
`configure/setup.md`.
