# Configuration

There is no dedicated settings page. Setup is two steps: enable the REST
resources so the endpoints exist, and (optionally) tailor the reset email.

## 1. Enable the REST resources

The two endpoints are standard REST resource plugins. Enable them the same way
you would any REST resource — using the **REST UI** module is the easy path:

- `lost_password_resource` → `POST /user/lost-password`
- `lost_password_reset` → `POST /user/lost-password-reset`

In REST UI (**Configuration → Web services → REST**), enable each resource, set
the method to **POST** and the format to **json**. (REST UI requires you to pick
an authentication provider; the module supplies a dummy "Na" option to satisfy
that requirement — the endpoints are deliberately anonymous.) The module also
shows inline help explaining the steps.

**Clear caches after saving** (`drush cr`). This is important: the module rewrites
these routes at build time to make them anonymous and CSRF-exempt, and to teach
`/user/login?_format=json` to accept the temp password — and that only takes
effect after a cache rebuild.

### Security note

Because the lost-password endpoints are unauthenticated (a password-reset flow
cannot require an existing session), put **rate limiting or a WAF** in front of
them exactly as you would for core's `/user/password`. The module ships none.
The reset itself is safe: it requires the emailed temporary token, which is
compared in a timing-safe way, only works for active accounts, and is deleted on
use — there is no arbitrary-account takeover.

## 2. Configure the reset email

The reset email settings live on the core **Account settings** page. Go to
**Configuration → People → Account settings**
(`/admin/config/people/accounts`); the module adds a **Rest Password recovery**
section with:

- **Subject** — the email subject line. Default: *"Replacement login information
  for [user:display-name]"*.
- **Body** — the email body. It should include the temporary password via the
  `[user:rest-temp-password]` token.
- **Token length** — the **byte length** used to generate the temporary password
  (its entropy). If left unset, the code default is 10 bytes (roughly 80 bits).

The mail is only sent when the module's notification flag is on, which the
install step enables by default.

### Useful custom tokens for the email

The module registers these tokens for use in the subject/body:

- `[user:rest-temp-password]` — the generated temporary password.
- `[user:mail-url-encode]` — the account email, URL-encoded (handy for building a
  deep link into your front end).
- `[user:name-url-encode]` / `[user:name-url-encode-spaces]` — the username,
  URL-encoded (spaces as `%20` in the second form).
- `[user:one-time-login-url]`, `[user:cancel-url]` — the core-style URLs.

## Admin convenience: send a reset email from the user list

The module adds a **Send reset password email** operation to each row on the
People/user listing, for users with the **Administer users** permission. It
mails the account a fresh temporary password. This is the only action the module
itself gates behind a permission.
