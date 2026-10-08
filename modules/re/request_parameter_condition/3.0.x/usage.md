<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Request Parameter Condition adds a condition for processing request parameters.

---

Request Parameter Condition provides a **condition plugin that evaluates request query parameters** — so
block visibility (or other condition-driven behaviour) can depend on the presence/value of a URL query
parameter (e.g. show a block only when `?campaign=summer`). It is in the Conditions package.

Use it to drive visibility from query parameters. It is a site-building/conditions feature. Note query
parameters are **user-controlled input**: this condition only decides visibility (it doesn't grant access), so
never use it as a security gate — a user can set any query parameter, so it must not be the sole control
protecting sensitive blocks/content. It has no access-control role. Configure the request-parameter
condition.

---

- Evaluate request query parameters.
- Drive visibility from query params.
- Show a block on ?param=value.
- Provide a condition plugin.
- Serve site building.
- Condition on the URL query.
- TREAT query params as user-controlled.
- Not use it as a security gate.
- Not protect sensitive content with it alone.
- Have no access-control role.
- Configure the condition.
- Handle request conditions.
- Condition on parameters.
- Configure visibility.
- Check query params.
- Configure the condition.
- Handle the plugin.
- Gate on parameters.
- Set the condition.
- Provide a request-parameter condition.
