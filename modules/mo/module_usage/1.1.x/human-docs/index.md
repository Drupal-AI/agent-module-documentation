# Module usage — manual setup guide

**Module usage** (`module_usage`) lets site builders document **how, where, and why**
each contrib or custom module is used on a site. For any module you can record
descriptions and free‑form notes (historical context, testing instructions, or
anything else), plus a list of URLs where the module is used or should be tested —
each URL carrying its own notes field. It is a knowledge base that lives alongside
your modules, aimed at QA teams and anyone who inherits a site and needs to know what
everything is for.

It integrates seamlessly with the core module list: on the **Extend** page
(`/admin/modules`) each module gains a "Module Usage Documentation" accordion at the
bottom of its description pane, and you can filter the list to modules that do, or
don't, have documentation. The same integration appears on the module updates page and
the Available updates report. Historical activity — installs, uninstalls, and version
changes — is tracked automatically, and the module ships Views integration and
reports.

You can move documentation between environments (local/dev/stage/prod) using
**import/export**, available both as Drush commands and in the admin UI. Module usage
provides a set of granular permissions (view, create, edit, delete, and a restricted
administer permission), and it depends on the **jQuery UI Accordion** module for its
UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   jQuery UI Accordion dependency) and enable the module.

There is no central settings form; you use the module inline on the module list and
through its import/export tools, described below.

## Where it lives in the admin menu

- **Documentation UI** — inline on the **Extend** page (`/admin/modules`): open a
  module's description accordion, then its **Module Usage Documentation** accordion to
  add or edit notes and URLs.
- **Reports and import/export** — under **Extend → Documentation**, where the Import
  and Export screens live.

## How to use it

1. After installing (see [Installation](installation/index.md)), go to
   **`/admin/modules`** and expand a module's description, then its Module Usage
   Documentation accordion. Add a description, notes, and any URLs (with per‑URL
   notes).
2. Use the filter to show only documented, only undocumented, or all modules.
3. Review automatically tracked install/uninstall and version‑change history, plus the
   Views‑based reports.
4. To move documentation between site copies, use import/export — see the Drush
   commands below or the **Extend → Documentation → Import/Export** screens.

## Import and export with Drush

```bash
# Export (defaults: file moduse.json, path private:/moduse, all modules)
drush moduse:export [--file=<export-file-name.json>] [--path=<export-folder>] [--modules=mod1,mod2,mod3]

# Import (defaults: file moduse.json, path private:/moduse)
drush moduse:import [--file=<export-file-name.json>] [--path=<export-folder>]
```

The same import and export operations are available in the admin UI under **Extend →
Documentation**.
