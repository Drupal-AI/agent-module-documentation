# Configure login/registration behavior

## Where to configure

Email Registration has **no dedicated settings form**. Its one option is injected into the core
**Account settings** form: `entity.user.admin_form` → `/admin/config/people/accounts` (under an
"Email Registration" details section, added by `hook_form_user_admin_settings_alter`).

## Settings — config object `email_registration.settings`

| Key | Default | Meaning |
|---|---|---|
| `login_with_username` | `false` | When **false**, users log in with their email only (the login/reset form's name field becomes an `email` input titled "Email address"). When **true**, they may log in with **either** email or username. |

Set it by UI, or:

```
drush cset email_registration.settings login_with_username true
```

Config schema: `config/schema/email_registration.schema.yml` (`type: config_object`). It exports
with `drush config:export`. Nothing else is stored — usernames are generated at save time, not
configured.

## What the module changes on the user forms

- **Registration/edit form** (`user_form`): the email field is forced required; the username
  field is hidden (`#type` = `value`) unless the current user has `change own username` (for their
  own account) or `administer users`. On new accounts the username may be left blank — a validate
  handler fills a temporary `email_registration_<uuid>` name so core's non-empty rule passes, then
  the real name is generated in `hook_user_presave`.
- **Login form** (`user_login_form`) and **password-reset form** (`user_pass`): the name field is
  relabeled/typed for email; login is validated by `user_load_by_mail()`, and blocked/inactive
  accounts get a clear error.
- **REST/JSON login** (`user.login.http`): a `RouteSubscriber` repoints the controller to
  `UserHttpAuthenticationController::login` so programmatic logins accept email too.

## Bulk action — regenerate usernames for existing users

The module ships a `user`-type action plugin **`email_registration_update_username`**
("Update username (from email_registration)"), pre-created as
`system.action.email_registration_update_username`. Select users on the **People** view
(`/admin/people`) and run it to reset each username to a temporary `email_registration_<uuid>`
value and re-save, which triggers `hook_user_presave` to regenerate the real name from the email.

## Related welcome-email tip

Because the visible name is now auto-generated, edit the account/welcome emails on the same
Account settings form and replace the `[user:display-name]` token with `[user:mail]`.
