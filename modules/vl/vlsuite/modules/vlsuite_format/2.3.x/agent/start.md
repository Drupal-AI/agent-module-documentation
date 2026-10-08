<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite Format (vlsuite_format) — agent index

Submodule of **vlsuite**. **Text formats and CKEditor 5 configuration** for the suite's text
components. Version **2.3.3**. Core `^10.3 || ^11`.
Depends on `ckeditor5`, `editor`, `media`, `vlsuite`.

**Say this: text formats are an access control.** The allowed-HTML list is what stands between an
editor and script injection; a format permitting arbitrary HTML grants effective JS execution to
everyone who can use it. Review what these formats allow and which roles hold them — especially
where content editors are not trusted administrators.

**Debugging note:** a component that drops formatting is usually the *format* stripping markup, not
the component. Check there first.