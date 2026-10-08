# Configuration

No Request New Password has exactly one setting. Until you turn it on, the module
does nothing.

## Open the settings form

1. Log in as a user with the **Administer noreqnewpass** permission.
2. Go to **Configuration → People → No Request New Password**, or navigate directly
   to `/admin/config/people/noreqnewpass`.

## The setting

- **Disable Request new password link** (`noreqnewpass_disable`, default
  **unchecked**) — when checked, the module:
  - hides the "Request new password" link on the user login block and user pages,
    and
  - denies access to the `/user/password` route so a reset can't be requested
    there.

Leave it unchecked to keep Drupal's normal password-reset behavior.

## Save

Click **Save configuration**. Submitting the form automatically rebuilds the router
so the change to the `/user/password` route access takes effect immediately.

If you instead set the value directly from the command line, rebuild routes
yourself so the route access is re-evaluated:

```bash
# turn it on
drush config:set noreqnewpass.settings_form noreqnewpass_disable true -y
drush cr

# turn it off (back to core behavior)
drush config:set noreqnewpass.settings_form noreqnewpass_disable false -y
drush cr
```
