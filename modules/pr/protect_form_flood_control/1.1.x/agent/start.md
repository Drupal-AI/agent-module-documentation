<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Protect Form Flood Control — agent index

Applies core's `flood` service to arbitrary forms: block a client after `threshold` submissions of
a form within `window` seconds. All state is one config object, `protect_form_flood_control.settings`.
No dependencies beyond core.

- **Config keys, protection selection (protect-all vs list), per-form overrides, whitelist, drush** →
  [configure/settings.md](configure/settings.md)
- **How it hooks forms and calls the flood service (mechanism)** → [api/mechanism.md](api/mechanism.md)

Key facts:
- Configure route: `protect_form_flood_control.settings` → `/admin/config/user-interface/protect-form-flood-control`.
- Service: `protect_form_flood_control.manager` (`Drupal\protect_form_flood_control\Manager`).
- Permissions: `administer protect form flood control`, `bypass protect form flood control`,
  `view protect form flood control form ids`.
- Never protects `system_*`, `search_*`, `views_exposed_form_*`, or its own settings form.
