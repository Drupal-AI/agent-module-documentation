<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Manage State provides a user interface to view and manage data stored in the Drupal State API system.

---

Manage State provides an administrative UI to inspect and manage the Drupal State API — the
key/value store used for non-configuration runtime state (last-cron time, various flags, counters). It
lets developers/administrators view state keys and their values and edit or delete them, at
`manage_state.state_overview`. It provides its own permissions and is tagged as a developer tool.

Use it during development and debugging to inspect or reset state values without Drush/`drush state:*`.
The security-relevant point is that state can hold sensitive operational values, and editing state can
change site behaviour — so restrict the permission to trusted administrators and use it carefully
(changing or deleting state can break functionality). It is a developer/administration tool; keep its
access tight, especially on production.

---

- View Drupal State API values.
- Manage state key/value data.
- Edit or delete state values.
- Inspect runtime state.
- Configure at manage_state.state_overview.
- Provide its own permissions.
- Debug state without Drush.
- Restrict the permission to admins.
- Use carefully on production.
- Reset state flags.
- Inspect last-cron and counters.
- Change site behaviour via state.
- Avoid breaking functionality.
- Treat state as sensitive.
- Keep access tight.
- View state keys.
- Edit state entries.
- Manage non-config state.
- Support developer debugging.
- Tag as a developer tool.
