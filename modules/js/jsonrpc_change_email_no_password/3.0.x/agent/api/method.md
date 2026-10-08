<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON-RPC method: user.change_email_no_password

Plugin: `Drupal\jsonrpc_change_email_no_password\Plugin\jsonrpc\Method\ChangeEmailNoPassword`.

- **id:** `user.change_email_no_password`
- **access:** `["jsonrpc change email no password"]`
- **params:** `mail` (string) — the new email address.
- **returns:** the new email string on success, or an error string (`"Error: ..."`).

## Semantics
```
$uid = $this->currentUser->id();          // ALWAYS the caller
$account = user_storage->load($uid);
if ($account->hasRole('admin')) return 'Error: Admins cannot change ...';
$account->setEmail($mail);
$account->save();
```
There is no target-user parameter, so the method can only change the authenticated caller's email. It deliberately skips the password confirmation core requires. Exceptions are logged to `exception_jsonrpc_email`.

## Operational guidance
Because password re-authentication is removed, treat the permission as sensitive: a stolen session/token on a permitted account can repoint its email and then trigger a password reset. Keep it off admin roles (already enforced in code) and pair with app-layer step-up auth if needed.
