# Amazon SES permissions

From `amazon_ses.permissions.yml`:

| Permission | Gates | Notes |
|---|---|---|
| `administer amazon ses` | All Amazon SES admin routes: settings, verified identities (list/verify/delete), test email, statistics. | `restrict access: true` — flagged as security-sensitive in the permissions UI. |

There is one permission only. Verifying/deleting identities and sending test mail make live AWS SES API
calls (billable, and identity changes affect real sending), so grant it only to trusted administrators.
