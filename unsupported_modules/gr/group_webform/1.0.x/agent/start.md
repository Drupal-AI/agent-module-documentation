<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Webform (group_webform) — agent index

**Exposes each webform as a Group 3.x relation type so `webform_submission` entities are owned by and access-controlled through Groups.**

- **Version:** 1.0.x (1.0.0-beta3 per composer.lock; no version in info.yml — dev checkout)
- **Core:** ^10 || ^11
- **Requires:** `drupal/webform ^6.3@beta`, `drupal/group ^3.2`
- **Plugin:** GroupRelationType `group_webform` (entity_type_id `webform_submission`, **entity_access = TRUE**, cardinality forced to 1), derived per webform by `GroupWebformDeriver`.
- **Group permission:** `access group_webform overview`.
- **Services:** `group_webform.route_subscriber` (RouteSubscriber — `alterRoutes()` is a no-op / dead code).
- **Security:** Access is delegated to Group core via `entity_access = TRUE`, so group membership/permissions gate submission create/view/update/delete — no over-grant and no custom access bypass. No custom routes/controllers, no mutating anonymous endpoints. See [plugins/relation.md](plugins/relation.md).