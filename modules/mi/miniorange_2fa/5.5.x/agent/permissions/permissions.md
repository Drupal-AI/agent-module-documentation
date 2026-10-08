# miniOrange 2FA permissions

Defined in `miniorange_2fa.permissions.yml`. Most are `restrict access: true` (grant only to trusted
admins). They gate the module's admin tabs; the end-user 2FA setup/challenge routes are NOT permission-
gated — they are guarded by the `mo_auth` login-session state instead (see
[../api/login-flow.md](../api/login-flow.md)).

| Permission | `restrict access` | Gates |
|---|---|---|
| `miniorange 2fa customer setup` | true | Account & License tab — register/deregister the miniOrange account and disable 2FA for all users. |
| `miniorange 2fa login settings` | true | The site-wide 2FA policy: enable/disable, role/domain rules, allowed methods, reconfigure, IP rules, etc. |
| `miniorange 2fa user management` | true | User-management tab: reset / enable / disable 2FA per user (the `reset/{user}`, `update_status/{user}/{enabled}` endpoints — also CSRF-protected). |
| `miniorange 2fa headless` | true | Headless / API 2FA setup tab. |
| `miniorange 2fa licensing` | (not restricted) | Licensing / upgrade-plan tab (informational). |

Other admin routes (`configure_admin_2fa`, `addons`, `custom_kba_ques`, `allowed_2fa_methods`,
`organization-branding`, `setup_twofactor`, `re_configure`, `update_phone`, `configure_backup_method`)
require core `administer site configuration` or the `authenticated` role (for the user's own
reconfigure/update-phone modals).

Notes for agents:
- All the powerful/destructive tabs (disable-all-2FA, per-user reset) sit behind `restrict access: true`
  perms **and**, for state changes, a CSRF token — treat these as trusted-admin only.
- `miniorange 2fa licensing` is the only non-restricted one and is informational (upgrade prompts); it
  does not change 2FA enforcement.
- The submodules add their own permissions: `miniorange_webauthn` (`mo_access_user_profile`,
  `mo_anonymous_user`) and are documented in their trees.
