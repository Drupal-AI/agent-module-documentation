<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the consent-gated field group

Prereqs: EU Cookie Compliance configured with categories enabled; Field Group installed.

1. On the entity's **Manage display** (a view mode), create a field group and move the fields you want to gate into it.
2. Set the group's format to **EU Cookie Compliance**.
3. In the group settings choose the **Cookie category** required to display the fields (options come from EU Cookie Compliance's `cookie_category` storage).

Runtime behaviour (`preRender`): reads `\Drupal::request()->cookies->get('cookie-agreed-categories')` (a JSON array). If the cookie is NULL or does not contain the configured category, every child of the group is unset — the fields are absent from the HTML, not merely CSS-hidden. The element gets cache context `cookies:cookie-agreed-categories` and `max-age = 0`.

Required site config (README):
- Disable the **Internal Page Cache** module.
- Add to `sites/default/services.yml` (`required_cache_contexts`): `cookies:cookie-agreed-categories` (see the module's `services_example.yml`).

Note: gating is based on a client cookie value, so treat it as a consent/privacy convenience, not authorization.
