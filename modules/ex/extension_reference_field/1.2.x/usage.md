<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds an "Extension" field type that stores a reference to a Drupal extension (module, theme, or profile) by its machine name, with a select widget and a label formatter.

---

Extension Reference Field is a small, dependency-free field module (package "Field types") that lets any fieldable entity hold a reference to one or more Drupal extensions. Its field type `extension_reference` stores the extension machine name in a `target_id` varchar column and exposes a computed `extension` property that resolves that name to a core `Extension` object on read. Two storage settings shape the field: the extension **type** it targets (Module, Theme, or Profile) and the extension **status** used to build the option list (Enabled, Disabled, or Enabled and disabled). The default select widget (`extension_reference_select`, extending core `OptionsSelectWidget`, multi-value capable) presents the matching extensions as a dropdown, and the label formatter (`extension_reference_label`) prints each referenced extension's human name, optionally turning it into a link to the extension's drupal.org project page when the extension carries drupal.org packaging metadata (a `project` key in its info). The module has no settings form, routes, permissions, Drush commands, or install hooks; you add the field through the standard Manage fields UI and configure the widget/formatter on Manage form display / Manage display.

---

- Add an "Extension" field to a content type, taxonomy term, user, or any fieldable entity to record which module/theme/profile a piece of content relates to.
- Build a curated catalog or knowledge base of modules where each node references a real installed extension.
- Let editors pick an extension from a validated dropdown instead of typing a free-text machine name.
- Reference a theme from content (for example a "recommended theme" showcase entry).
- Reference an installation profile from configuration or documentation entities.
- Store multiple extension references on one field (the select widget supports multiple values).
- Restrict the selectable options to a single extension type (modules only, themes only, or profiles only) per field.
- Restrict the option list by status so editors choose only from currently enabled extensions.
- Include disabled/not-installed extensions in the option list when documenting the full codebase on disk.
- Display a referenced extension by its human-readable name using the label formatter.
- Turn the displayed extension name into a link to its drupal.org project page for contrib extensions.
- Read the resolved core `Extension` object in custom code via the field's computed `extension` property.
- Drive views, tokens, or custom logic from a stored extension machine name.
- Tie release notes, changelog entries, or support tickets to the specific extension they concern.
- Record dependencies or "related modules" relationships between documentation entities.
- Generate sample content that references random enabled extensions during development (the field supplies `generateSampleValue()`).
- Reuse the field across bundles and entity types wherever an extension reference is needed.
- Combine the field with core Fields UI (Manage form display / Manage display) with no extra configuration screens.
- Keep the reference stable across deployments by storing the extension machine name rather than a numeric id.
- Present a compact, config-driven picker for extensions inside a site-building or admin workflow.
