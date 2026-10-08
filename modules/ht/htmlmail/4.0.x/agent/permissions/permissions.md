# htmlmail — permissions

From `htmlmail.permissions.yml`:

| Permission | Gates |
|---|---|
| `choose htmlmail_plaintext` | Lets a user see and use the "Plaintext-only emails" checkbox on their own account form, opting out of HTML mail. |

Notes:
- Users with `administer users` also get access to the checkbox even without this permission
  (`HtmlMailHelper::allowUserAccess()`).
- The two admin forms (`htmlmail.settings`, `htmlmail.test`) are gated by the core
  `administer site configuration` permission, not by a module-specific permission.
