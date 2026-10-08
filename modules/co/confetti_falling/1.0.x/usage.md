<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Confetti Falling adds a **falling-confetti visual effect** to the front end, triggered on pages that contain a
configured CSS class name. It is a decorative/celebration effect implemented as an attached JS library.

Use it for celebration moments — a thank-you page, a completed order, a holiday landing page — where a light
confetti animation is desired without custom JavaScript.
---
- No dependencies beyond core; enable with `ddev drush en confetti_falling`.
- Configure at `/admin/config/confetti_falling_settings` (route `confetti_falling.settings`,
  permission `administer site configuration`).
- Set the **class name** of the pages/elements where confetti should fall.
- The module attaches its JS library and triggers the animation when the class is present.
- No content is created; the effect is purely client-side.
- Adjust or disable by changing the target class or uninstalling.
---
- Show confetti on a thank-you or confirmation page.
- Celebrate a completed checkout or form submission.
- Add a holiday/seasonal decorative effect.
- Trigger the effect by CSS class on any page.
- Configure the target class from the admin form.
- Keep the effect purely front-end (no server load).
- Reuse across multiple pages via a shared class.
- Enable/disable without code changes.
- Pair with landing pages for campaigns.
- Provide a lightweight celebration cue.
- Limit the effect to specific elements via class.
- Avoid writing custom animation JavaScript.
- Restrict configuration to site administrators.
- Use on event or milestone pages.
- Toggle the effect by editing the configured class.
- Remove entirely by uninstalling the module.
