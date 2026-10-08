<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
commercetools is the base module integrating the commercetools headless platform (needs a UI submodule).

---

commercetools provides the base integration of the commercetools (a headless/API-first commerce platform) with Drupal — it's ONLY the base module and provides no UI, so you also install one of the UI modules: commercetools Content (renders commercetools content on the Drupal side) or commercetools Decoupled (renders it on the frontend as decoupled Web Components).

It connects Drupal to a commercetools project via its API using OAuth2 client credentials (Client ID, Client secret, Project key, API scope, hosted region), entered on the settings page and stored in Drupal configuration. Products, customers and orders stay on the commercetools side; Drupal only caches catalog data. Supports Drupal 10 and 11.

---

- Integrate commercetools with Drupal.
- Provide the base module only.
- Provide no UI itself.
- Require a UI submodule.
- Offer Content or Decoupled UIs.
- Connect via the commercetools API.
- Authenticate with OAuth2 client credentials.
- Serve headless commerce.
- Cache catalog data locally.
- Keep PII on the commercetools side.
- Support Drupal 10 and 11.
- Configure the connection on the settings page.
- Underpin the UI modules.
- Integrate a headless platform.
- Handle commercetools.
- Support decoupled commerce.
- Connect to a project.
- Provide a base.
- Invalidate caches via cron or Subscriptions.
