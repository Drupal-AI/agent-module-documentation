<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Last Login shows the current user their previous login time via a lightweight block.

---

The module stores the user's last login time in a session variable and exposes it through a 'Last Login Time' block that the site builder places in any region. It is intentionally minimal - it creates no database table and has no configuration or routes - and is only meaningful to authenticated users, who see their own previous login timestamp after logging in again.

---

- Show the current user their last login time.
- Place a 'Last Login Time' block in any region.
- Store the last login time in a session variable.
- Avoid creating any extra database table.
- Provide a lightweight, config-free login indicator.
- Reassure users by surfacing recent login activity.
- Display the timestamp only to logged-in users.
- Integrate via the standard Block UI.
- Support Drupal 8, 9, and 10.
- Add login-time visibility with minimal overhead.
- Use core session storage, no custom schema.
- Help users notice unexpected prior logins.
- Require re-login to populate the value.
- Keep the footprint tiny and dependency-free.
- Show per-user login timing in the theme.
- Offer a simple activity-awareness cue.
