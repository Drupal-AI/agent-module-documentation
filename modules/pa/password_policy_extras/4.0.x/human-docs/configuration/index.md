# Configuration

Password Policy Extras works as soon as it is enabled — these settings only tune how the live
constraint feedback looks and behaves. If you never open the form, you still get the
AJAX-refreshing status table with its defaults.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Security → Password Policy → Extras**, or navigate directly to
   `/admin/config/security/password-policy/extras/settings`.

## The settings, one by one

Each option maps to a value in the `password_policy_extras.settings` config object. The
defaults are chosen for a clean, modern experience — most sites can leave them as-is.

- **Disable AJAX progress** (`disable_ajax_progress`, default **on**) — removes the little
  AJAX throbber/spinner that would otherwise flash each time the password is re-checked as the
  user types. Turn it off if you prefer a visible progress indicator.

- **Failed messages only** (`failed_messages_only`, default **on**) — shows only the rules the
  password currently *fails*, instead of Password Policy's full three-column table of every
  rule. This is much less noisy for the user; untick it to show the complete policy table.

- **Hide password suggestions** (`hide_password_suggestions`, default **on**) — hides Drupal
  core's built-in password-strength suggestion text, so the only feedback the user sees is
  your policy status. Untick it to keep core's suggestions.

- **Display status after password** (`display_status_after_pass`, default **on**) — moves the
  policy status display to directly **below** the main password field, where it reads
  naturally. Untick it to leave the status in its default position.

- **Display status on focus** (`display_status_on_focus`, default **on**) — reveals the status
  table only when the password field gains focus, keeping the form tidy until the user starts
  entering a password. When on, the "hide when empty" behaviour is removed so the table can
  appear on focus.

- **Status refresh delay** (`status_refresh_delay`, default **500**) — the debounce, in
  milliseconds, between the user's last keystroke and the AJAX re-check. A higher value means
  fewer, later refreshes (lighter on the server); a lower value feels more instant. Setting it
  to **0** disables the delayed refresh entirely.

## Save

Click **Save configuration**. Changes take effect on the next password form the user opens
(registration, edit account, password reset, and any custom or contrib password forms the
submodules cover).

## Going further

The two events (`password_policy_extras.skip_visibility` and
`password_policy_extras.skip_validation`) and the reusable form-helper functions let a custom
module add this live feedback to its own password forms, or suppress it per route. Those are
developer-facing — see the [`agent/`](../../agent/start.md) docs (`api/events.md`) for the
details.
