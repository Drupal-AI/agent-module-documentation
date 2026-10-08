<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Jquery UI Field defines a field type for building Tabs and Accordions: each field item holds a label and a description, and formatters render the collected items as jQuery UI Tabs or as a jQuery UI Accordion.

---

The module provides a `JqueryuiFieldType` field type (label + description columns), a default widget, and two formatters — `JqueryuiFieldTabFormatter` (`#theme => jqueryui_field` rendered as tabs) and `JqueryuiFieldAccordionFormatter` — plus the jQuery UI library assets and templates. Editors add multiple label/description rows to a field; the display formatter turns them into interactive tabbed or accordion content.

This is a content-display/field feature. Values are editorial content entered by users with field edit access and rendered through Twig templates; the module adds no routes or permissions and has no access-control role. As with any field that stores descriptive text, the description's rendering follows the field/text-format handling configured for it.

---

- Store label/description pairs in a field.
- Render items as jQuery UI Tabs.
- Render items as a jQuery UI Accordion.
- Build tabbed content without custom code.
- Build accordions from field data.
- Add multiple tab/accordion sections per field.
- Enter labels and descriptions in the widget.
- Choose tabs or accordion via the formatter.
- Attach jQuery UI assets automatically.
- Reuse on any fieldable entity.
- Organize long content into collapsible sections.
- Present FAQs as an accordion.
- Present grouped content as tabs.
- Configure per field instance display.
- Depend on the core field module.
- Add no routes or permissions.
