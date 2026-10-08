<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Alert Types lets you define different types of alerts using Drupal's bundle system (each alert type is a fieldable bundle), create prioritized alert entities, and display the active ones anywhere on the site through an AJAX-loaded block.

---

Alert types are config entities; alerts are revisionable content entities with visibility rules (paths, bundles, roles) and optional user or timed dismissal. The Alerts block renders active alerts, and a JSON endpoint (`/alerts/json`) returns the rendered markup of all active, access-checked, published alerts for the front-end JavaScript to inject — so alerts respect cache contexts and paths. Behavior plugins (annotation `@AlertTypeBehavior`; ships Dismissable and Dismiss Timer) plus a JavaScript plugin API let you customise display and behavior; a dismissed alert is remembered in a cookie.

Setup: enable the module, place the Alerts block into a region, create an Alert Type at `/admin/structure`, then add alerts at `/admin/content/alerts`. Drag-and-drop ordering sets priority (weight).

---

- Create a new fieldable alert type (bundle)
- Add fields to an alert type to extend its data
- Create an alert entity at `/admin/content/alerts`
- Place the Alerts block into a region
- Prioritize alerts by drag-and-drop weight
- Restrict an alert to specific paths
- Restrict an alert to specific content bundles
- Restrict an alert to specific roles
- Make an alert user-dismissable (cookie-remembered)
- Auto-dismiss an alert after a timer
- Consume active alerts via the `/alerts/json` endpoint
- Write a custom `@AlertTypeBehavior` plugin
- Pair a behavior plugin with a JavaScript plugin/library
- View, revert, and delete alert revisions
- Grant per-operation alert permissions to roles
- Show only active alerts to visitors via `view active alert entities`
- Translate alert entities
- Theme alerts with the provided templates
- Toggle an alert's active/inactive status
- Build a site-wide announcement banner
