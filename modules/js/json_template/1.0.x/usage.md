<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON Template picks up various JS templates (Handlebars, Mustache, etc.) and makes them available for front-end rendering.

---

JSON Template provides infrastructure to register and load client-side JavaScript templates —
Handlebars, Mustache and similar — so front-end code can render data into markup in the browser. It is a
developer/theming utility used by modules or themes that render JSON data client-side (for example
recommendation blocks or dynamic widgets). Other modules (like Recombee) depend on it for their front-end
rendering.

Use it as a dependency/infrastructure for client-side templated rendering. It is a developer/JavaScript
feature; templates render data in the browser, so — as with any client-side templating — ensure data
passed into templates is properly escaped to avoid client-side injection (use the templating engine's
escaping, not raw interpolation). It has no content or access behaviour of its own.

---

- Load client-side JS templates.
- Support Handlebars/Mustache.
- Render data in the browser.
- Provide front-end templating infrastructure.
- Serve as a dependency for other modules.
- Support Recombee rendering.
- Register JS templates.
- Escape data in templates.
- Avoid client-side injection.
- Use the engine's escaping.
- Have no content/access behaviour.
- Render dynamic widgets.
- Template JSON data client-side.
- Support front-end rendering.
- Provide templating for JS.
- Load templates for the front end.
- Render recommendation blocks.
- Handle client-side templates.
- Escape interpolated data.
- Provide JS templating.
