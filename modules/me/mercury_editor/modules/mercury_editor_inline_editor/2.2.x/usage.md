<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mercury Editor Inline Editor is a **deprecated** submodule of Mercury Editor. It ships only an `.info.yml` placeholder (no code) kept for backwards compatibility; its functionality moved to the separate project `mercury_editor_live_edit`.

---

This submodule no longer provides any behaviour. In current Mercury Editor releases the directory contains a single `mercury_editor_inline_editor.info.yml` whose header explicitly states the module is deprecated and should be replaced by `drupal.org/project/mercury_editor_live_edit`. The `.info.yml` still declares a dependency on `layout_paragraphs` and can technically be enabled, but enabling it does nothing useful — there is no `.module`, no services, no routes, no config, and no permissions. It exists purely so that sites which previously enabled it do not break on update. For inline / live editing of Mercury Editor components you should install and enable the `mercury_editor_live_edit` contrib project instead.

---

- Recognise that `mercury_editor_inline_editor` is a deprecated, empty compatibility shim.
- Understand that its replacement is the `mercury_editor_live_edit` project.
- Keep an existing site booting after upgrade without removing the old module immediately.
- Identify that enabling it adds no features (no code ships).
- Plan a migration path from the old inline editor to `mercury_editor_live_edit`.
- Audit a site for deprecated Mercury Editor submodules to uninstall.
