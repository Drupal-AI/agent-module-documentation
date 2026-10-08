# Set up & behavior — Login with Email or Username

## Setup

There is **no configuration**. Enable the module and the behavior is active:

```
drush en login_emailusername -y
```

No settings form, no config object, no `config/install`, no `config/schema`, no
`configure` route, and no permissions are defined. Uninstalling reverts to
username-only login with nothing left behind. Depends only on core `user`.

## What it changes on the HTML login form

Implemented in `login_emailusername.module` via
`hook_form_FORM_ID_alter()` on `user_login_form`:

- Relabels `$form['name']['#title']` to **"Username or email address"**.
- Sets `$form['name']['#description']` to "Enter your username or email address."
- Appends `login_emailusername_user_login_validate` to `#element_validate`.

## How email → username resolution works

`login_emailusername_user_login_validate($form, $form_state)`:

1. Reads the submitted `name` value.
2. `user_load_by_name($name)` — if a **username** matches, done (returns TRUE).
3. Otherwise `user_load_by_mail($name)` — if an **email** matches, it rewrites the
   form value: `$form_state->setValue('name', $user->getAccountName())` so core's
   normal password authentication runs against the resolved username.

So in source the **username is checked first**, then email as a fallback. The
resolved real username is what core authenticates — no other login logic is altered,
and password checking, flood control, and blocked-account handling stay core's.

(Note: the README text says email is checked before username; the actual code checks
username first, then email. Source is authoritative here.)

## REST / HTTP endpoints

`src/Routing/RouteSubscriber.php` (an `event_subscriber` service in
`login_emailusername.services.yml`) overrides two core routes to a subclass of
core's `UserAuthenticationController`
(`LoginEmailUsernameUserAuthenticationController`):

| Route | New controller method | Behavior |
|---|---|---|
| `user.login.http` | `::login` | If `credentials['name']` is not a username, tries `user_load_by_mail()` and swaps in that account's username before flood control + `lookupAccount()`. |
| `user.pass.http` | `::resetPassword` | Accepts a `name` **or** `mail` credential; looks the account up by the given property and falls back to the other, then sends the core password-reset email. |

This is what allows decoupled/JSON clients to authenticate (or request a password
reset) with an email address instead of a username.
