<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Smart Content Data Layer provides dataLayer integration for Smart Content. It exposes a condition group / attributes that read values from the browser's `window.dataLayer` (as populated by Google Tag Manager or similar), so personalization decisions can segment visitors on analytics/tag-manager data.

Use it when your segmentation signals already live in the dataLayer and you want Smart Content to react to them.

---

Install (requires `smart_content`). A decision-settings event subscriber injects the dataLayer condition configuration into the Smart Content decision JS settings. When authoring segments you gain dataLayer-backed conditions whose keys map to dataLayer properties.

No admin routes or permissions are added by this submodule; configuration happens within Smart Content segment authoring. Front-end JS reads the dataLayer and supplies the values the conditions evaluate against.

---

- Read segmentation signals from `window.dataLayer`.
- Integrate Google Tag Manager data with Smart Content.
- Add dataLayer-backed condition attributes.
- Evaluate decisions against tag-manager values.
- Inject dataLayer settings into decision JS.
- Reuse dataLayer keys across segments.
- Avoid custom JS to expose analytics data to personalization.
- Segment visitors by campaign/analytics properties.
- Work with any dataLayer-populating tag manager.
- Extend Smart Content's condition system.
- Require no separate admin UI.
- Depend only on smart_content.
- Support Drupal 9.1+ and 10.
- Hook into the decision-settings event.
- Keep personalization client-side and cacheable.
- Pair with other Smart Content submodules.
