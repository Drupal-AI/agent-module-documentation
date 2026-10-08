<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Apigee Extras is an umbrella module that groups optional add-ons for the Apigee Edge integration: a Views bridge for developer apps and Bootstrap 5 theming for Apigee portal elements.

---

Apigee Extras sits on top of the **Apigee Edge** module (Google's API management platform and developer portal for Drupal). The base `apigee_extras` module contains no PHP, routes, config, or permissions of its own — it only declares the `apigee_edge` dependency and packages two submodules you can enable independently. **Apigee Extras Views** (`apigee_extras_views`) registers an `apigee_app` Views base table plus a field handler and a query plugin that pull developer apps straight from the Apigee Edge storage, so site builders can list app name, display name, status, developer email, description and creation date through the normal Views UI. **Apigee Extras Bootstrap** (`apigee_extras_bootstrap`) implements a single preprocess hook that turns the Apigee `status_property` element into a Bootstrap 5 pill badge, mapping status strings (active, pending, revoked, expired, …) to contextual `bg-*` colour classes. Enable whichever submodule matches your need; the base module by itself does nothing beyond pulling in Apigee Edge.

---

- Enable `apigee_extras` as a lightweight umbrella that guarantees Apigee Edge is present.
- Add the Apigee developer-portal Views bridge by enabling `apigee_extras_views`.
- Build a Views listing of Apigee developer apps without writing a custom controller.
- Show app name, display name and status columns in a Views table.
- Expose the owning developer email as a Views field for admin dashboards.
- Sort or filter a developer-app view by app name (string handlers).
- Use the app name as a contextual filter (argument) in a view.
- Surface app description and creation date in a report.
- Feed an admin overview page of all developer apps from a view display.
- Re-skin the Apigee `status_property` element as a Bootstrap 5 badge by enabling `apigee_extras_bootstrap`.
- Get colour-coded app/API status pills on a Bootstrap 5 theme out of the box.
- Map custom Apigee status strings to Bootstrap contextual colours via a preprocess override.
- Keep an existing Bootstrap5-based theme visually consistent with Apigee portal markup.
- Override `status-property.html.twig` in your theme to further customise badge markup.
- Combine the Views and Bootstrap submodules to build a styled developer-app dashboard.
- Provide a starting point for extending Apigee Edge portal functionality.
- Group Apigee add-on features under one composer package (`drupal/apigee_extras`).
- Enable only the submodule you need and leave the other disabled to reduce surface.
- Target Drupal 10.3+ or 11.1+ Apigee Edge sites.
