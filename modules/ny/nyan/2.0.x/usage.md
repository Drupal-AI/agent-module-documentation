<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Nyan cat progress bars swaps Drupal's standard progress bar for an animated Nyan-cat-themed one.

---

The module attaches assets that restyle/replace the core progress bar used during batch operations and AJAX throbbers with a Nyan-cat animation. A settings form at `/admin/config/system/nyan` (`NyanSettingsForm`, gated by the `administer nyan` permission, which is `restrict access: true`) lets you customise the bar, with defaults stored in `nyan.nyansettings`.

It is a purely cosmetic user-interface enhancement with no data handling, external calls, or content routes. Enable it to make long-running batch/import screens more fun; disable or restrict it where a serious tone is required.

---
- Make batch-operation progress bars more playful.
- Replace the default progress bar with a Nyan-cat animation.
- Brighten long imports or migrations with a fun throbber.
- Customise the progress bar via the settings form.
- Add personality to admin batch screens.
- Restrict configuration to admins with a dedicated permission.
- Keep progress-bar styling in configuration.
- Delight users during unavoidable waits.
- Apply the themed bar sitewide by enabling the module.
- Turn tedious progress screens into a talking point.
- Use on internal tools where a light tone is welcome.
- Revert easily by disabling the module.
- Pair with heavy batch jobs for morale.
- Provide a memorable loading experience at events/demos.
- Adjust defaults stored in `nyan.nyansettings`.
- Limit who can change the bar's appearance.
