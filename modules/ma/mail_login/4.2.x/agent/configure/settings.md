# Configure Mail Login

Single admin form at **`/admin/config/people/mail-login`** (route `mail_login.admin`, title
"Mail Login", parent People admin index) behind the `administer mail login` permission. All
settings live in one config object, **`mail_login.settings`** — export/deploy with
`drush config:export`, or set individual keys with `drush cset mail_login.settings <key> <value>`.

## Settings keys (with install defaults)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `mail_login_enabled` | integer | `1` | Turn email login on. When on, an identifier that validates as an email is resolved to the account by its `mail` property. |
| `mail_login_case_sensitive` | integer | `1` | `1` = match emails case-sensitively (RFC 5321). `0` = case-insensitive match, accepted only when exactly one account matches. |
| `mail_login_email_only` | integer | `0` | `1` disables username login entirely; a non-email identifier is rejected with "Login by username has been disabled. Use your email address instead." (Only shown/applies when email login is enabled.) |
| `mail_login_override_login_labels` | integer | `1` | Enable overriding the login/reset form field titles & descriptions below. |
| `mail_login_username_title` | text (translatable) | `Log in by username/email address` | Login form name-field title (mixed mode). |
| `mail_login_username_description` | text (translatable) | `You can use your username or email address to log in.` | Login form name-field description (mixed mode). |
| `mail_login_email_only_title` | text (translatable) | `Log in by email address` | Login form name-field title (email-only mode). |
| `mail_login_email_only_description` | text (translatable) | `You can use your email address only to log in.` | Login form name-field description (email-only mode). |
| `mail_login_password_only_description` | text (translatable) | `Enter the password that accompanies your email address.` | Login form password-field description (email-only mode). |
| `mail_login_password_reset_username_title` | text (translatable) | `Username or email address` | `user_pass` name-field title (mixed mode). |
| `mail_login_password_reset_username_description` | text (translatable) | `Password reset instructions will be sent to your registered email address.` | `user_pass` name-field description (mixed mode). |
| `mail_login_password_reset_email_only_title` | text (translatable) | `Email address` | `user_pass` name-field title (email-only mode). |
| `mail_login_password_reset_email_only_description` | text (translatable) | `Password reset instructions will be sent to your registered email address.` | `user_pass` name-field description (email-only mode). |

Config schema: `config/schema/mail_login.schema.yml` (type `config_object`; label fields are
`translatable: true`). Uninstalling the module deletes `mail_login.settings`.

## How the email → account resolution works

- **Auth service decorator** — `Drupal\mail_login\AuthDecorator` (in `mail_login.services.yml`,
  `decorates: user.auth`). Its `lookupAccount($identifier)`: if email login is enabled and the
  identifier passes `FILTER_VALIDATE_EMAIL`, it loads the user by `mail`. If none found and
  `mail_login_case_sensitive` is `0`, it retries a `LIKE` match and accepts it only when exactly
  one user matches. If the identifier is *not* an email and `mail_login_email_only` is on, it
  errors and returns `FALSE`. Blocked accounts are rejected with a message.
- **Form validation** — `mail_login_validate_authentication()` (added in `mail_login.module`
  via `hook_form_alter`, inserted before core's `::validateFinal`) resolves a submitted email to
  the *canonical username* and rewrites the `name` value so Drupal's flood control keys on one
  consistent identifier for both username and email attempts.
- **Label overrides** — the same `hook_form_alter` swaps in the titles/descriptions above on
  `user_login_form` and `user_pass` only when `mail_login_override_login_labels` is on.

Note: this is authentication + login-form customization only; it does **not** change user
registration. (Contrast `login_emailusername`, which also affects the registration flow.)
