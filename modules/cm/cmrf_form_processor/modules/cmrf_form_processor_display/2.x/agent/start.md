<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CMRF Display Only field (cmrf_form_processor_display) — agent index

Submodule of **[cmrf_form_processor](../../../../2.x/agent/start.md)**. Adds a **display-only
Webform element** whose value is populated by the parent's Form Processor handler (e.g. a
calculation output or a default value) and shown to the user rather than submitted. Package
`CiviCRM`. Core `^8 || ^9 || ^10 || ^11`. Depends on `cmrf_form_processor`. Installed **2.2.20**.

## What it provides (from source)

- **Webform element plugin** `cmrf_display` (`Plugin/WebformElement/CMRFDisplay`, extends
  `WebformMarkupBase`, category "CMRF"). `isInput()` returns TRUE so the element can be populated
  with a default value, but the parent handler filters `cmrf_display` elements out of the values it
  sends to CiviCRM (`FormProcessorBaseHandler::getSubmittedElements()`), so they never post back.
  Config properties: `cmrf_display_mode` (`literal` / `link` / `button`), `cmrf_display_text`
  (link/button label), `cmrf_display_atts` (CSS classes for the button).
- **Render element** `cmrf_display` (`Element/CMRFDisplay`, extends `FormElement`,
  `#input => FALSE`). Its `preRenderCmrfDisplay()` renders the populated `#value` as: raw markup
  (literal), an `<a target="_blank">` link, or a styled `<a>` "button". Link/button/attribute
  values are emitted through `t()` `:placeholder` sanitisation.
- The `.module` file is an empty stub — no hooks. No routes, services, permissions, schema, or
  install hooks.

See the parent for how the value reaches the element: [[cmrf_form_processor]].
