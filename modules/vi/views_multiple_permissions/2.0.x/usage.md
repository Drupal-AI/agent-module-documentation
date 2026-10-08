<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Multiple Permissions is a Views access plugin that grants a display based on several permissions combined with AND or OR logic, rather than core's single-permission access.

---

Core's Views permission access plugin checks exactly one permission. Real access rules are often "editors OR moderators may see this", or "must have both review AND publish". Expressing that means a custom access plugin or a contortion of roles. This module adds a Views access plugin that takes a set of permissions and an operator — All required (AND) or At least one (OR) — so the display's access matches the actual rule.

Because this is access-control code, its correctness was checked, and it is right. The `access()` method returns TRUE as soon as any permission matches under OR, returns FALSE as soon as any is missing under AND, and its terminal `return $this->options['operator'] === 'and'` handles both fall-through cases correctly — OR reaches it only when nothing matched (deny), AND reaches it only when everything matched (allow). It also mirrors the decision into the route requirement via `alterRouteDefinition()`, using Drupal's `,` (AND) and `+` (OR) permission-glue convention, so the view is gated consistently at both the Views and routing layers.

One edge to know: with an empty permission list the AND operator returns TRUE (vacuously "all zero permissions held"), which would grant everyone — a configuration foot-gun rather than a code defect, and the default is a sensible single `access content`. So configure the permission set deliberately and prefer an explicit permission over an empty AND.

For any view whose visibility depends on more than one permission, this is the correct, clean tool.

---

- Grant a view by multiple permissions.
- Require all of several permissions.
- Require any of several permissions.
- Use AND logic for view access.
- Use OR logic for view access.
- Let editors or moderators see a view.
- Require review and publish permissions.
- Avoid a custom access plugin.
- Combine permissions for a display.
- Gate a view at route and Views layers.
- Express a real access rule.
- Set the permission operator.
- Restrict a report to two roles.
- Configure the permission set deliberately.
- Avoid an empty AND permission list.
- Match view access to policy.
- Control display visibility.
- Use permission-based view access.
- Secure a view by capability.
- Combine capabilities cleanly.