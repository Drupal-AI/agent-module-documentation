<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google Optimize JS conditionally injects the Google Optimize `optimize.js` snippet into the page head on the pages you choose, so you can run Google Optimize A/B tests and experiments on a Drupal site.

---

The module adds an `Inclusion` service that decides, per request, whether the Optimize snippet should be attached. It uses the current path, path alias, path matcher and admin-route context to include or exclude the snippet according to the container ID and page-visibility rules configured on the settings form. Administrators enter the Google Optimize container ID and a list of paths at `/admin/config/system/google_optimize`.

This is an integration/front-end feature, not an access-control tool. The `administer google optimize` permission gates only who can configure the container ID and inclusion rules; it does not restrict content. The snippet is emitted client-side, so treat the container ID as public. Excluding admin routes avoids interfering with the Drupal admin UI.

---

- Add Google Optimize to a Drupal site via `optimize.js`.
- Run A/B tests and multivariate experiments on selected pages.
- Configure the Optimize container ID in the admin UI.
- Include the snippet only on specific paths.
- Exclude the snippet on other paths using visibility rules.
- Match paths using aliases via the path alias manager.
- Keep the snippet off Drupal admin routes.
- Gate configuration with the `administer google optimize` permission.
- Attach the snippet in the page head for anti-flicker.
- Decide inclusion per request through the `Inclusion` service.
- Pair with Google Analytics / Tag Manager experiments.
- Target landing pages for conversion testing.
- Roll out personalization experiments to page subsets.
- Avoid a custom block or template edit to add the snippet.
- Centralize experiment enablement in one config form.
- Toggle experiments on and off without code changes.
