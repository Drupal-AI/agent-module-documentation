<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `jwt_oauth_ccf.permissions.yml`:

| Permission | Restricted? | Grants |
|---|---|---|
| `manage own oauth client credentials` | no | Create, view, and delete OAuth client credentials **on your own account** (`/user/{own-uid}/oauth-clients...`). |
| `administer oauth client credentials` | **yes** (`restrict access: true`) | Create, view, and delete OAuth client credentials **on any account**. |

## How they're enforced

Both are checked together by the `_jwt_oauth_ccf_manage_access` route requirement
(service `jwt_oauth_ccf.access_checker`,
`Drupal\jwt_oauth_ccf\Access\ManageClientsAccessCheck::access()`) on all three
`/user/{user}/oauth-clients...` routes:

```php
$is_admin = $account->hasPermission('administer oauth client credentials');
$is_own   = $account->id() === $user->id() && $account->hasPermission('manage own oauth client credentials');
return AccessResult::allowedIf($is_admin || $is_own);
```

So a plain user needs `manage own oauth client credentials` and must be viewing their own
`{user}` route parameter; an account with `administer oauth client credentials` can manage
any user's credentials regardless of whose page it is.

## Why `administer oauth client credentials` is security-sensitive

A credential can mint tokens that **fully impersonate the account it belongs to** — every
role and permission that account has. Grant it only to trusted roles, and prefer creating
dedicated, least-privilege service accounts for M2M integrations rather than binding
credentials to a privileged human admin account.

## Not permission-gated

The token endpoint itself, `POST /oauth2/token`, requires **no permission** — it is
`_access: 'TRUE'` (anonymous). Its own gate is the client_id/client_secret pair supplied in
the request, not a Drupal permission.
