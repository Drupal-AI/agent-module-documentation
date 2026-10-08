# REST endpoints & the temp-password flow

Two REST resource plugins plus a modified core login route. All accept/return JSON
(`?_format=json`). See [../configure/setup.md](../configure/setup.md) for enabling them.

## 1. Request a temp password — `POST /user/lost-password`

Resource `lost_password_resource` (`GetPasswordRestResource`).

Body:
```json
{ "mail": "user@example.com", "lang": "en" }   // lang optional
```

Behaviour:
- Loads the account by email. If found **and active**, generates a temp password, stores it in the
  `rest_password` shared tempstore under key `temp_pass_<uid>` (owner = uid), and mails it via the
  `password_reset_rest` mail key.
- Response is always the generic `{"message": "Further instructions have been sent to your email
  address."}` (HTTP 200) whether or not the email exists or the account is blocked — no account
  enumeration. Missing `mail` → 400 "Please Post mail key." Mail-send failure → 400.
- The temp password is delivered **only** to the account's registered email.

## 2. Set a new password with the temp password — `POST /user/lost-password-reset`

Resource `lost_password_reset` (`ResetPasswordFromTempRestResource`).

Body:
```json
{ "name": "USERNAME_or_email", "temp_pass": "EMAILED_TEMP", "new_pass": "NEW_PASSWORD" }
```

Behaviour:
- Loads user by name, then by email. Requires the account to be active.
- Reads `temp_pass_<uid>` from the `rest_password` tempstore and compares with
  `hash_equals($stored, $temp_pass)`. **A new password is set only on a match** — the token is
  mandatory.
- On success: `setPassword(new_pass)`, dispatch `PasswordResetEvent::PRE_RESET`, save, dispatch
  `POST_RESET`, delete the temp password (single use); HTTP 200. Wrong token →
  "The recovery password is not valid."; no request on file → "No valid temp password request.";
  all three fields required else 400.

## 3. Log in with the temp password — `POST /user/login?_format=json`

The route subscriber repoints core `user.login.http` to
`UserAuthenticationTempPassController::login`. It behaves exactly like core JSON login (returns
`current_user`, `csrf_token`, `logout_token`) but adds a fallback: if normal `user.auth`
authentication fails, it loads the user by name, reads `temp_pass_<uid>` from the tempstore
(`getIfOwner`) and, if `hash_equals($credentials['pass'], $temp_pass)` matches, logs the user in
and adds `"temp_pass": "A Temp password has been used please update your password"` to the response.

Body:
```json
{ "name": "USERNAME", "pass": "EMAILED_TEMP_OR_REAL_PASSWORD" }
```

Notes:
- Core **flood control** applies (IP + per-user, default 5 / 6h) around both the real-password and
  temp-password checks.
- Unlike endpoint #2, this path does **not** delete the temp password after a successful login
  (the `deleteIfOwner` call is commented out), so the temp password keeps working until it is used
  via `/user/lost-password-reset` or replaced by a new lost-password request.
- The controller also carries a `resetPassword()` method (core-style `password_reset` mail), but no
  route is wired to it by this module.

## Flow summary

```
POST /user/lost-password {mail}              -> temp password emailed to the account
   then either
POST /user/lost-password-reset {name,temp_pass,new_pass}  -> sets new password, consumes token
   or
POST /user/login {name, pass=temp_pass}      -> logs in directly (token not consumed)
```
