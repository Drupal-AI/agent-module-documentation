<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Personal Contact Form Link provides a **Display Suite (DS) field** that outputs a link to a user's **personal
contact form** (`/user/{uid}/contact`). Placed on the user entity display, it gives a one-click "contact this
user" link.

Use it on user profile displays managed with Display Suite when you want a ready-made contact link without
theming it by hand. Visibility of the link follows core's personal contact form access rules.
---
- Requires the `ds` (Display Suite) module; enable with `ddev drush en contact_link`.
- On **Manage display** for the user entity (using a DS layout), place the **contact link** DS field.
- The field renders a link to the target user's personal contact form.
- Link visibility respects core personal-contact-form access (the target user must have it enabled and the
  viewer must have permission).
- No configuration form or permissions of its own.
- Works across Drupal 8/9/10.
---
- Add a "contact this user" link to profile displays.
- Render the link as a Display Suite field.
- Respect core personal contact form access rules.
- Avoid hand-theming a contact link.
- Place the field via the Manage display UI.
- Use on user entity view modes.
- Combine with other DS fields in a layout.
- Link directly to `/user/{uid}/contact`.
- Support D8–D10 sites.
- Keep display configuration deployable.
- Hide automatically when contact is unavailable.
- Reuse across multiple user view modes.
- Integrate with DS layouts and regions.
- Provide a consistent contact affordance on profiles.
- Require no custom code.
- Remove by unplacing the field or uninstalling.
