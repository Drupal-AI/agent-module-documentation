# Library Manager — manual setup guide

**Library Manager** (`library_manager`) gives Drupal's asset‑library system an
**administrative interface**. Instead of editing a `*.libraries.yml` file and
writing a `hook_library_info_alter()` in code, you define new libraries, override
existing ones, and author the JavaScript and CSS right in the browser — in a
CodeMirror editor — and the module writes the files to disk and attaches them like
any other library.

It's genuinely useful for a small class of jobs: adding a third‑party widget's
snippet, patching the load order of a stubborn library, injecting a tracking or
accessibility script, or prototyping a front‑end change without cutting a release.
You can add JS and CSS by code, by upload, by local path, or by external URL; set
per‑file options like preprocessing, minification, header placement, and
`type="module"` / `nomodule`; declare dependencies, version, and licence; override
any library any extension declares; and duplicate, export, or delete definitions.
There's also an assets‑check report at `/admin/reports/libraries`.

It has an obvious trade‑off worth understanding up front: **front‑end code
authored here stops living in version control.** Everything you add is site
*configuration*, so it exports and deploys with config — but it won't appear in a
code review of your theme, and a developer grepping the repository won't find it.
Use it for genuine site configuration, not as a substitute for the theme.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside the
   CodeMirror Editor dependency, and enable it.
2. [Configuration](configuration/index.md) — the settings form, the per‑file
   options when building a library, and the one setting to leave alone.

## Where it lives in the admin menu

- **Library list:** **Structure → Library** (`/admin/structure/library`) — where
  you add, edit, duplicate, export, and delete library definitions.
- **Settings:** **Structure → Library → Settings**
  (`/admin/structure/library/settings`, route `library_manager.settings`).
- **Assets report:** **Reports → Libraries** (`/admin/reports/libraries`).

Everything except the report is gated by the **Administer libraries** permission,
which is marked *restricted* — see [Configuration](configuration/index.md).

## How to use it

1. Go to **Structure → Library** and add a new library definition.
2. Add its JS and CSS — by writing code in the CodeMirror editor, uploading a
   file, pointing at a local path, or referencing an external URL — and set each
   file's options.
3. Declare any dependencies, version, and licence, then save.
4. Attach the library where you need it (for example from a theme, a block, or via
   visibility rules), and check **Reports → Libraries** to review what the site
   defines.
