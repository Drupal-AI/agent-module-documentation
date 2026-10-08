# Configuration

Persistent Login works out of the box; this form only tunes how the remembered logins
behave.

## Open the settings form

1. Log in as a user with the core **Administer site configuration** permission.
2. Go to **Configuration → System → Persistent Login**, or navigate directly to
   `/admin/config/system/persistent_login`.

## The fields

- **Lifetime** — the number of **days** a remembered login stays valid, minimum 0. Enter
  **0 for no expiration** (the user stays logged in indefinitely). Default is 30.
- **Extend lifetime when used** — when ticked, a remembered login is renewed from its last
  use rather than from when it was created, so an active user is never logged out. This
  field is only meaningful (and only shown) when *Lifetime* is not 0; it is forced off when
  the lifetime is 0.
- **Maximum Tokens** — the maximum number of remembered devices per user, minimum 0. Enter
  **0 for no limit**. Set it to 1 to allow only one remembered device per account. When a
  user exceeds the limit, the oldest remembered login is dropped as a new one is created.
- **Form Label** — the text of the checkbox on the login form. Defaults to "Remember me";
  change it to "Stay signed in" or "Keep me logged in" if you prefer. This label is
  translatable per language through config translation. Required.
- **Cookie Prefix** — the prefix used when naming the persistent-login cookie (default
  `PL`). It may only contain letters, numbers, hyphens and underscores, and it cannot be
  `SESS` (to avoid clashing with core's session cookie). Required.

  > **Changing the cookie prefix logs everyone out.** Every existing remembered login is
  > invalidated when you change this value, so all users will have to log in again. That
  > also makes it a deliberate "revoke every remembered login site-wide" switch if you ever
  > need one.

Click **Save configuration**.

## Good to know

- Uninstalling the module drops its database table, so all remembered logins are lost.
- The maximum-tokens limit is enforced *when a new remembered login is created*, not
  retroactively — lowering it does not immediately purge existing tokens.
- Remembered logins are cleared automatically on logout, when an account is cancelled or
  deleted, and expired ones are purged on cron.
- An administrator can clear another account's remembered logins from that user's edit
  form ("Logout all other devices"), and users can do the same for themselves by changing
  their password.
