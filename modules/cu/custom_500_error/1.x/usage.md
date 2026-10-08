<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom 500 Error lets an administrator replace the body of Drupal's HTTP 500 (Internal Server Error) page with their own markup.

---

Install and enable the module the normal way (`composer require drupal/custom_500_error` then enable it, or drop it in `modules/contrib` and enable on the Extend page); it has no dependencies beyond Drupal core and adds no libraries. Configuration is a single settings page at **Administration → Configuration → System → Custom 500 Internal error config** (`/admin/config/custom_500_error/customerrorconfig`), reachable by users with the **access administration pages** permission. The page offers one rich-text field, *Markup which you want to be shown in the error page*, whose value is stored in the config object `custom_500_error.customerrorconfig` under the key `custom_error_markup`. When an uncaught exception produces a 500 response for an HTML request, the module's exception subscriber returns your stored markup as the whole response body — there is no template or theme wrapper, so include any headings, text and inline HTML/CSS you want the page to have. Because the shipped install config does not seed a default, save the form once after enabling so the 500 page is not empty; you can also set the value from code with the config factory or `drush cset custom_500_error.customerrorconfig custom_error_markup '<h1>…</h1>'`. Trigger a real error (or temporarily throw one in a test environment) to confirm the page renders as intended before relying on it in production.

---

- Install the module with Composer or from a downloaded archive.
- Enable it on the Extend page or with `drush en custom_500_error`.
- Open `/admin/config/custom_500_error/customerrorconfig` to configure it.
- Replace the plain default 500 page with your own markup.
- Write a friendly, on-brand "something went wrong" message.
- Add inline HTML and CSS to style the error page.
- Include your logo or a support link in the error body.
- Keep the error page consistent with the rest of the site's look.
- Store the markup in `custom_500_error.customerrorconfig:custom_error_markup`.
- Set the markup from code via the config factory.
- Set the markup with `drush cset` in a deployment script.
- Save the form once after install so the 500 page is not empty.
- Give trusted staff the "access administration pages" permission to edit it.
- Preview the result by triggering a test 500 in a non-production environment.
- Confirm the custom page renders before going live.
- Export the config with the rest of your site configuration.
- Apply the same 500 markup across environments via config sync.
- Restrict who can reach the settings form to appropriate roles.
- Update the message when support contacts or branding change.
- Remove or blank the markup to fall back to an empty custom body.
- Re-check the page after Drupal core upgrades.
- Uninstall the module to restore Drupal's default 500 behavior.
