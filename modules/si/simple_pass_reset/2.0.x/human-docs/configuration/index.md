# Configuration

Simple Password Reset works out of the box — the streamlined flow is active as soon
as you enable the module. The only thing you can configure is **where a user ends up
after they reset their password and are logged in**.

## Open the settings form

1. Log in as a user with the **Administer simple pass reset** permission (an
   administrator by default).
2. Go to **Configuration → People → Account settings → Simple Password Reset**, or
   navigate directly to `/admin/config/people/accounts/simple_pass_reset`.

## The redirect setting

The form has a single field:

- **Redirect path** — the internal path to send the user to once they've set their
  new password and been logged in. The default is **`/user`** (the user's own profile
  page).

Rules for the value:

- It must be an **internal path that starts with `/`** — for example `/user`,
  `/admin/content`, or `/dashboard`.
- You can enter the literal **`<front>`** to send users to your site's front page;
  the module stores that as `/`.
- The path is validated when you save, so it has to resolve to a real route. An
  external URL is not accepted.

If the value is ever left empty, the module falls back to sending users to their own
profile page.

## Save

Click **Save configuration**. The new destination applies to the next password reset
immediately.

## Setting it from the command line

You can also set the value with Drush instead of the form:

```bash
# Send users to the content overview after reset:
drush config:set simple_pass_reset.settings login_redirection '/admin/content' -y

# Send users to the front page (what entering <front> stores):
drush config:set simple_pass_reset.settings login_redirection '/' -y

# Read the current value:
drush config:get simple_pass_reset.settings login_redirection
```

## Permission

- **Administer simple pass reset** — controls who can open and change this settings
  form. It does **not** affect who can use the password-reset link itself; that
  remains Drupal core's flow, with core's security checks re-applied by this module.
