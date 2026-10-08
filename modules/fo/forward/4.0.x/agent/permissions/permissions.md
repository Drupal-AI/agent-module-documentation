<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

From `forward.permissions.yml`:

| Permission | `restrict access` | Gates |
|---|---|---|
| `access forward` | no | Use the Forward form / send forwards (route `forward.form`). Commonly granted to anonymous + authenticated — that is the module's purpose. Still requires view access to the target entity. |
| `override email address` | no | A logged-in user may change the sender email on the form. Without it, the sender email is forced to their account email (hidden field). |
| `administer forward` | **yes** | The settings form at `/admin/config/user-interface/forward`. |
| `override flood control` | **yes** | Bypass the per-hour send limit (`forward_flood_control_limit`). |

Notes:
- Granting `access forward` to anonymous is expected (public "email a friend"). The send path is
  protected by flood control (default 10/hr) and `forward_max_recipients` (default 1), and rendered as
  the anonymous user so it cannot leak access-restricted content. Recipient addresses are validated
  (`email.validator`) and `Reply-To` is header-encoded, so it is not an open header-injection relay —
  but as with any public mail form, operators add CAPTCHA/Honeypot for spam as needed.
- `override email address` is deliberately non-restricted (it only affects the sender's own address).
- Keep the two `restrict access: true` permissions on trusted roles.
