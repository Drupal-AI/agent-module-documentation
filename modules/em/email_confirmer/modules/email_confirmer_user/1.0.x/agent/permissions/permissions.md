# Email confirmer user — permissions

Source: `email_confirmer_user.permissions.yml`.

| Permission | restrict access | Gates |
|---|---|---|
| `email confirmer user bypass email change` | (not set → false) | Change a user's email address without requiring confirmation of the new address. Checked in `hook_user_presave`; holders skip the whole confirmation flow (and any pending change on that user is cleared). |

Grant this only to trusted administrative roles that legitimately manage other users' accounts
(e.g. user administrators). It bypasses email verification but does not itself grant any account-edit
capability — editing a user's email still requires normal user update access.
