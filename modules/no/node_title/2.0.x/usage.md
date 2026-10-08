<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node Title adds an extra `node_title` base field to nodes and exposes it in a collapsible "Node Title" group on the node edit form for cases where an additional or alternate title is needed.

---


The module is code-only: `hook_entity_base_field_info()` declares the base field and `hook_form_node_form_alter()` moves it into a details group in the form's advanced sidebar. There are no routes, permissions, services, or settings. It is a lightweight building block for storing a second title value alongside the standard node title.

Setup: enable the module; the extra field appears automatically on node forms.
---
- Store an additional title value on nodes.
- Show the extra title in a collapsible group on the node form.
- Provide an alternate/marketing title separate from the main title.
- Read the `node_title` base field in Twig or code.
- Reference the extra title in view modes.
- Group the extra title under the node form advanced section.
- Keep the extra title optional per node.
- Use the value in custom display logic.
- Populate the field programmatically on node save.
- Expose the field to Views as a node field.
- Migrate a legacy secondary title into the field.
- Add the field to all content types at once (base field).
- Keep title data without adding a configured field.
- Hide or show the group via form alter.
- Use the field for search or listing labels.
