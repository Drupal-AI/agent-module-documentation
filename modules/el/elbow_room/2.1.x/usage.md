<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Elbow room

Adds a per-user / site option to hide the sidebar (the second "advanced" column) on node add/edit forms so editors get a wider main editing area.

- Targets the node add/edit form layout, not content display.
- Ships CSS/JS libraries plus a small state script that remembers the toggle.
- Purely an editing-UX convenience; it changes no data and grants no access.

---

# Installing & configuring

- Enable the module (`drush en elbow_room`).
- Grant the `administer elbow room settings` permission to trusted roles.
- Configure it at `/admin/config/content/elbow-room` (route `elbow_room.settings`, `ElbowRoomAdminForm`).
- The admin form stores its options in the `elbow_room.*` config namespace.
- CSS/JS are provided via `elbow_room.libraries.yml` and attached on the node form.

---

# Usage & behaviour

- Editors see a toggle to collapse/expand the node form sidebar.
- The sidebar hosts core "advanced" groups (authoring info, revision, path, etc.).
- Hiding it widens the primary body/field editing column.
- The `elbow_room_state.js` script persists the chosen state client-side.
- The setting is a display preference; it never hides fields from saving.
- Works on standard node add and edit routes.
- Compatible with Claro/Gin-style admin themes.
- No new entities, routes beyond the settings form, or DB tables are created.
- Only the settings form is access-controlled (`administer elbow room settings`).
- No anonymous-facing routes are exposed.
- Does not alter which fields a user may edit; core field access still applies.
- Safe to enable/disable without data migration.
- Uninstalling removes the config and libraries only.
- Useful on sites with many advanced sidebar groups cluttering the form.
- Pairs well with modules that add extra vertical-tab groups.
- Has no runtime dependencies beyond Drupal core.
