<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Step by step provides guided journeys: a **step-by-step overview** node listing ordered **step pages**, with a "part of" block that tells a visitor where they are in the sequence.

---

The shape mirrors LocalGov Guides but is aimed at sequential tasks rather than reference material. `localgov_step_by_step_overview` holds `localgov_step_by_step_pages`, the ordered list of steps; `localgov_step_by_step_page` holds `localgov_step_parent` pointing at its overview. Saving a step page (`hook_node_insert()` / `hook_node_update()`) checks whether the overview already references it and, if not, appends it and saves the overview — with the whole operation wrapped in a try/catch that logs failures to the `localgov-step-by-step` channel rather than blocking the save. A `localgov_step_by_step_navigation` view renders the step list, and `hook_preprocess_views_view_list()` adjusts its markup so steps render as a numbered journey. The `StepPartOfBlock` block shows the containing journey and the current position on a step page. Preview Link integration (the module depends on `preview_link`) lets a whole journey be shared before publication via the `StepBySteps` autopopulate plugin. As with the other LocalGov content modules, `hook_modules_installed()` wires in optional fields when `localgov_services_navigation` or `localgov_topics` are present, and `hook_localgov_roles_default()` grants editor/author permissions — including scheduled-transition permissions when that module is in play.

---

- Publish a step-by-step journey such as "report a missed bin collection".
- Guide residents through a multi-stage application.
- Show visitors which step of a process they are on.
- Add a step and have it appended to the journey automatically.
- Reorder steps from the overview page.
- Provide a single entry URL that expands into ordered steps.
- Share an unpublished journey with a reviewer via a preview link.
- Break a complex service request into digestible stages.
- Attach a journey to a service in the LocalGov services tree.
- Classify journeys by topic.
- Render the step list as a numbered navigation view.
- Give each step its own URL for deep linking.
- Reuse the "part of" block across all steps.
- Keep the overview's step list correct without manual maintenance.
- Log sync failures rather than blocking an editor's save.
- Support scheduled publishing of journeys and steps.
- Build onboarding content for a new online service.
- Document an internal process for staff.
- Provide accessible sequential navigation.
- Migrate a long how-to page into discrete steps.
