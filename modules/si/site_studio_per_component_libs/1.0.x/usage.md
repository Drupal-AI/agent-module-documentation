<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Site Studio Per Component Library inspects the Acquia Site Studio (Cohesion) components rendered on a node and attaches a theme library whose name matches each component's machine name (UID). This lets a theme ship per-component CSS/JS that only loads when the component actually appears on the page.

Use it to keep Site Studio front-end assets granular - loading a component's styles/scripts on demand rather than globally.

---

Install the module (requires the `cohesion` / Acquia Site Studio module). In your active theme (and/or its base theme) define libraries named exactly after the Site Studio component UIDs you want to enhance. No configuration UI is provided.

On each node page, `hook_page_attachments_alter` walks the node's `cohesion_entity_reference_revisions` fields, decodes the canvas JSON, collects component UIDs (including nested children), and for every UID that resolves to a `{theme}/{uid}` library it attaches that library from the active theme and, if present, the base theme.

---

- Load Site Studio component CSS/JS only when the component is used.
- Match libraries to component machine names (UIDs) automatically.
- Traverse nested/child components in the canvas.
- Resolve libraries from the active theme.
- Also resolve libraries from the base theme.
- De-duplicate component UIDs before attaching.
- Work on any node with Site Studio canvas fields.
- Avoid globally loading all component assets.
- Keep front-end payloads component-scoped.
- Require no configuration or permissions.
- Integrate transparently via page attachments.
- Support Drupal 8.8+, 9 and 10.
- Read canvas JSON from `cohesion_entity_reference_revisions` fields.
- Skip components without a matching theme library.
- Pair with a component-driven Site Studio theme.
- Depend on the Acquia Site Studio (cohesion) module.
