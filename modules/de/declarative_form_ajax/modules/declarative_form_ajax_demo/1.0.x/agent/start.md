<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Declarative Form Ajax Demo (declarative_form_ajax_demo) — agent index

Example/test submodule of the Declarative Form AJAX project. Reference code only — not for production.
Version **1.0.0**, core `^10 || ^11`. Depends on `declarative_form_ajax`.

- **Routes** (`declarative_form_ajax_demo.routing.yml`, both `_access: 'TRUE'` — public demo forms):
  - `/demo/declarative-ajax-form` → `DeclarativeAjaxDemoForm`
  - `/demo/declarative-ajax-element-form` → `DeclarativeAjaxElementDemoForm`
- **Forms** (`src/Form/`): show `#ajax['updated_by']` on containers, details, textfields, checkboxes;
  the second targets an element nested in a custom render element.
- **Render element** (`src/Element/TestSelect.php`): `declarative_form_ajax_demo_select`, a `RenderElement`
  with its own built-in AJAX callback (`pluginDropdownCallback`) — demonstrates callback chaining.
- No config, permissions, services, or schema.

## Docs
- `agent/examples/forms.md` — the two demo forms, the custom element, and what each demonstrates.

Parent module: `../../../../declarative_form_ajax/1.0.x/agent/start.md`
