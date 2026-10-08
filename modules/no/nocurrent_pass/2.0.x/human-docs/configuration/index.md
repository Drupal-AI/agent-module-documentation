# Configuration

No Current Password has exactly one setting: whether the core **Current password**
field is required when someone edits a user account. It is a single checkbox on core's
account settings form.

## Open the setting

1. Log in as a user with the **Administer account settings** permission (an
   administrator by default).
2. Go to **Configuration → People → Account settings**, or navigate directly to
   `/admin/config/people/accounts`.
3. Find the **"Require Current Password"** fieldset the module adds to that form.

## The setting

- **Do not require current password** — a single checkbox.
  - **Ticked** → the current-password requirement is **removed**. On the user edit form
    (`/user/{uid}/edit`) and the change-password form
    (`/user/{uid}/change-password`), the **Current password** field is hidden and its
    validation is skipped, so email and password can be changed without re-entering the
    existing password. **This is the shipped default** — the box is ticked when you
    first enable the module.
  - **Unticked** → core's normal behaviour is restored — the current password is
    required to change email or password.

Click **Save configuration** to apply.

## The user 1 exception

There is one built-in exception you can't turn off: **user 1** (the first/superadmin
account) always keeps the Current password field, whatever this setting says. This
protects the site's most privileged account from having its credentials changed without
the existing password. Every other account follows the checkbox.

## What the setting actually changes

The module only touches the **editing forms** — it hides the current-password field and
tells core to skip that field's validation. It does not alter stored account data or
how passwords are hashed. Turning the setting on or off simply changes whether the
prompt appears going forward.

## Deploying the setting

The value is stored in the `nocurrent_pass.settings` config object (a boolean,
`nocurrent_pass_disabled`), so you can export and deploy it across environments with
Drupal's configuration sync. You can also read or set it from the command line:

```bash
# read the current value
drush cget nocurrent_pass.settings nocurrent_pass_disabled

# disable the requirement (hide current password)
drush cset nocurrent_pass.settings nocurrent_pass_disabled true -y

# restore core behaviour (require current password)
drush cset nocurrent_pass.settings nocurrent_pass_disabled false -y
```

The account settings form itself is admin-only (gated by core's **Administer account
settings** permission); the module adds no permission of its own.
