<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mercury Editor Task adds a dedicated "Mercury Editor" local task (tab) to node pages so editors can open the Mercury Editor page-building experience from a predictable route.

---

The module registers `/node/{node}/mercury-editor` as a custom-access entity form route (extending Mercury Editor's own HTML entity form controller) and exposes it as a tab beside the canonical node view via `mercury_editor_task.links.task.yml`. A settings form at `/admin/config/content/mercury-editor/task` (permission `administer site configuration`) lets a site builder tune how the task behaves, including how inline entity forms and the layout-paragraphs builder widget are presented. A form-alter service and an inline-entity-form manager (both injected with `config.factory`) adjust the node form; on the task route the controller hides the raw `layout_paragraphs_builder` widget so editing happens through Mercury Editor rather than the default widget, and a content-translation event subscriber/route subscriber keep translation routes consistent.

Operationally this is an admin/editor-facing companion to the Mercury Editor module (a hard dependency) with no anonymous or mutating public endpoints: the settings route is gated by `administer site configuration` and the per-node route uses a custom access check that defers to node edit access. Typical setup is enabling the module alongside Mercury Editor, visiting the settings form, and confirming the "Mercury Editor" tab appears on content that should use the builder.

---

- Enable the module to add a Mercury Editor tab to node editing
- Open `/node/{nid}/mercury-editor` to edit a node in Mercury Editor
- Visit `/admin/config/content/mercury-editor/task` to configure the task
- Control whether the layout-paragraphs builder widget is hidden on node forms
- Provide a consistent editing entry point for content teams
- Add the editor tab beside the canonical node view
- Integrate Mercury Editor with inline entity forms
- Keep content-translation routes aligned with the editor task
- Restrict the settings form to users with administer site configuration
- Defer per-node access to standard node edit permissions
- Present a predictable page-building route for editors
- Adjust node forms through the form-alter service
- Hide default layout widgets in favour of the Mercury Editor UI
- Support Schema.org Devel generate by visually hiding builder widgets
- Use the inline-entity-form manager to tune nested entity forms
- Offer a settings tab under the Mercury Editor admin section
- Standardise the editing experience across content types
- Pair with mercury_editor as a required dependency
- Give translators a Mercury Editor task on translation routes
- Roll out Mercury Editor to specific node bundles via the task route
