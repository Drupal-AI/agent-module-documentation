# autologout permissions

From `autologout.permissions.yml`:

- **`administer autologout`** — access the settings form (`autologout.set_admin`) and change
  all global, dialog, redirect, and role timeout options. Trusted/admin only.
- **`change own logout threshold`** — lets a user set their own personal inactivity timeout
  (bounded by `max_timeout`), unless `no_individual_logout_threshold` is enabled globally.
