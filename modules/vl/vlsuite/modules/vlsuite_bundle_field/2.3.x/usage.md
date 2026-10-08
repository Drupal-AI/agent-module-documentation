<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Bundle Field defines the fields the suite's block and collection bundles share.

---

Components have overlapping needs: most take a heading, many take a link, several take media or an icon. Defining those fields once and reusing them across bundles is what keeps a component library coherent — the same field name means the same thing everywhere, displays can be configured once, and a change propagates.

The alternative, which projects reach for by default, is a field per bundle with a slightly different name and settings. That works until someone needs to query across components, or translate them, or write a template that handles more than one.

Translation is why `content_translation` is a dependency: shared field definitions are what make a translatable component set tractable rather than a per-bundle exercise.

`vlsuite_collection` depends on this, and so does anything building bundles on the same foundation. If you are extending the suite with a component of your own, reuse these fields rather than adding parallel ones — the consistency is the point.

---

- Share a heading field across components.
- Reuse a link field in several bundles.
- Attach media through a shared field.
- Add an icon field to a component.
- Keep field names consistent across bundles.
- Configure a display once for many bundles.
- Translate component fields consistently.
- Query across components by field.
- Write one template handling several bundles.
- Extend the suite reusing existing fields.
- Avoid parallel field definitions.
- Propagate a field change across components.
- Keep the component library coherent.
- Audit which bundles use which fields.
- Plan a custom component's field set.