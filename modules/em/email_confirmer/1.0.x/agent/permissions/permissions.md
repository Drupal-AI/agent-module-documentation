# Email confirmer — permissions

Source: `email_confirmer.permissions.yml`; enforced by
`src/EmailConfirmationAccessControlHandler.php`.

| Permission | restrict access | Gates |
|---|---|---|
| `administer email confirmations` | **true** | Update/delete any confirmation without restriction; grants full entity access in the access handler. |
| `access email confirmation` | false | Use the confirmation service: respond to (confirm/cancel) and resend confirmations. **Disabled by default** — grant to roles that should use the service. |

## Access handler logic (`checkAccess`)
1. `administer email confirmations` → allowed for everything.
2. If `restrict_same_ip` is on and the request IP ≠ the confirmation's stored IP → forbidden.
3. If the confirmation is `private` and its uid is neither anonymous (0) nor the current user →
   forbidden.
4. Otherwise → allowed only if the account has `access email confirmation`.

Note the response-link security does not rely solely on this permission: `EmailConfirmation::confirm()`
independently requires the 43-char HMAC `{hash}` from the URL to match `getHash()`, so knowing/holding
the permission is not enough to confirm an address without the signed link.
