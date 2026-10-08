<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Apigee Extras Views exposes Apigee developer apps to the Drupal Views module as an apigee_app base table with field, filter, sort and argument handlers backed by a custom query plugin.

---

This submodule of **Apigee Extras** bridges Apigee Edge developer apps into **Views**. Its `hook_views_data()` (`apigee_extras_views.module`) declares an `apigee_app` base table whose rows are fetched by the `apigee_app_query` query plugin (`ApigeeAppQuery`) instead of SQL: the plugin loads `developer_app` entities from Apigee Edge storage and maps each app onto a Views `ResultRow`. Available fields are **name**, **display_name**, **status**, **developer_email**, **description** and **created_at**, all rendered through the `apigee_app_field` handler (`ApigeeAppField`, which escapes output via `sanitizeValue()`). The `name` field additionally offers string **filter**, standard **sort** and string **argument** handlers. With this in place a site builder can create a normal View on "Apigee Apps" and lay out a table, block or page of developer apps without writing a controller. It requires `views` and `apigee_extras` (hence `apigee_edge`).

---

- List all Apigee developer apps in a Views table.
- Show an app's machine name and human display name side by side.
- Display the app status (approved/revoked) column in a report.
- Surface the owning developer's email address as a Views field.
- Include the app description in a listing.
- Show when each app was created (`created_at`, formatted `Y-m-d H:i:s`).
- Build an admin dashboard/overview page of developer apps.
- Filter a developer-app view by app name (string filter).
- Sort a developer-app view by name (standard sort).
- Use the app name as a contextual filter/argument on a page view.
- Expose developer apps as a block on an admin section.
- Feed a "recently created apps" style listing via a view.
- Combine with Apigee Extras Bootstrap to style the status column as a badge.
- Prototype developer-portal admin screens quickly with the Views UI.
- Provide a read-only Views source for reporting on Apigee apps.
- Replace a bespoke controller that iterated developer apps with a view.
- Give non-developers a UI-configurable view of Apigee app metadata.
