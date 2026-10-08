<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Accesibilidad (machine name `accesibility`) is a Spanish-language accessibility helper that loads a JavaScript/CSS widget on every non-admin page so visitors can toggle night mode and a simplified navigation view.
---
The module's only server-side surface is one admin form at `/admin/config/accesibility/adminsettings` (route `accesibility.admin_settings_form`, gated by `access administration pages`) that stores two textarea messages ("Night mode" and "Simple navigation") in the `accesibility.adminsettings` config object. The widget itself is delivered entirely by the front-end library `accesibility/accesibility-library`, attached in `accesibility_page_attachments()` whenever the current route is not an admin route.

There is no permission of its own, no routing beyond the settings form, and no data collection — it is a presentational front-end enhancement. Operationally the only setup step is to place/enable the library-driven widget and optionally edit the two message strings. Note the module directory is `accesibilidad` while the actual Drupal machine name (info.yml + `\Drupal\accesibility` namespace) is `accesibility`; enable it with `drush en accesibility`.
---
- Enable the module to add an accessibility widget to the public site.
- Toggle a high-contrast / night mode from the front-end widget.
- Switch the page into a simplified-navigation reading mode.
- Edit the "Night mode" helper message at the settings form.
- Edit the "Simple navigation" helper message at the settings form.
- Restrict who can change the messages via the `access administration pages` permission.
- Confirm the widget appears on content pages but not on `/admin/*` routes.
- Provide a Spanish-language accessibility affordance out of the box.
- Attach the widget site-wide without per-page configuration.
- Customize the widget appearance by overriding the module's CSS library.
- Extend the widget behavior by overriding the module's JS library.
- Verify the config object `accesibility.adminsettings` after saving the form.
- Include the module in a base install profile for public sites.
- Audit that no anonymous-writable endpoint is exposed by the module.
- Disable the module to remove the widget from all pages.
- Translate the two message strings through Drupal's config translation.
- Combine with a theme that respects the night-mode CSS class.
- Use as a lightweight alternative to heavier accessibility toolbars.
- Ship the widget only to end users, keeping admin pages untouched.
- Review `accesibility_page_attachments()` to see the admin-route exclusion logic.
