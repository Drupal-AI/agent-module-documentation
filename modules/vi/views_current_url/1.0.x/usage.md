<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Current URL provides a global views field for the current URL or its parts/query parameters.

---

Views Current URL adds a **global Views field** that outputs the **current URL** — or extracted parts of
it (path segments, host) or specific **query parameters** — so a View can render or use the request URL (for
building links, showing context, or passing the current query into output). It depends on core Views, in the
Views package.

Use it to surface the current URL/query in a View. It is a content-display/Views feature. Note query
parameters are **user-controlled input**: if you render a query-parameter value, ensure it is output through
normal Views escaping (don't place raw request input into unescaped markup) — treat it like any reflected
request value. It has no access-control role. Add the field to a View.

---

- Output the current URL in a View.
- Extract URL parts or query params.
- Render/use the request URL.
- Depend on core Views.
- Build links from the current URL.
- Show URL context.
- TREAT query parameters as user-controlled input.
- Output query values through Views escaping.
- Avoid raw reflected request input.
- Have no access-control role.
- Add the field to a View.
- Handle the current URL.
- Expose the URL.
- Configure the field.
- Show the URL.
- Extract query params.
- Handle URL parts.
- Use the request URL.
- Configure Views.
- Provide a current-URL field.
