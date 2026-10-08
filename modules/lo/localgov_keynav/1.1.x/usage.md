<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov KeyNav lets users navigate a site by typing keyboard shortcut sequences that map to destinations, defined in a JSON sequence file and configurable per site.

---

When enabled for a user, the module attaches its `keynav` library (`js/keynav.js`, `js/keynav-sequences.json`) and pushes settings into `drupalSettings.localgovKeyNav`; typing a defined key sequence navigates to the associated part of the site. Access is gated by two permissions: `Use LocalGov keynav` (whether a user gets the shortcuts at all) and `Add LocalGov Keynav shortcuts` (which guards the settings form at `admin/config/user-interface/localgov-keynav`, where an administrator can add custom key-sequence patterns via `custom_keynav_patterns`). A boolean user field `localgov_keynav` (installed via config) lets each individual user disable the feature for themselves — `hook_preprocess_page` only attaches the library when the user has the permission and has not disabled it, and `hook_entity_field_access` controls visibility/editability of that field based on the permission.

The settings route is permission-gated and the module makes no external calls; navigation is entirely client-side. There are no mutating public endpoints. The main considerations are usability/accessibility (ensuring shortcuts don't clash with assistive tech) rather than security.

---
- Jump to a site section by typing a key sequence.
- Enable keyboard shortcuts for editors and admins.
- Grant the "Use LocalGov keynav" permission to chosen roles.
- Let each user disable KeyNav for themselves.
- Add custom key-sequence patterns in the settings form.
- Restrict who can configure shortcut patterns.
- Speed up navigation for power users on a LocalGov site.
- Provide consistent shortcuts across a council's site.
- Attach shortcuts only to permitted users.
- Configure sequences via the JSON sequence file.
- Improve keyboard-first workflows for content teams.
- Toggle the per-user opt-out field on the profile.
- Expose the KeyNav field only to permitted users (field access).
- Push shortcut settings to the browser via drupalSettings.
- Deploy KeyNav across Drupal 10/11 LocalGov installs.
- Document available shortcuts for your editors.
- Combine with other LocalGov Drupal navigation features.
