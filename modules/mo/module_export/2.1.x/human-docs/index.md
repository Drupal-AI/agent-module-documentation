# Module Export — manual setup guide

**Module Export** (`module_export`) generates a downloadable "glue" module — or a CSV
file — whose dependency list names every module currently enabled (or installed) on
your site. Drop that generated module into another Drupal site, enable it, and it
pulls in the same module set as dependencies, so you can replicate one site's module
list on another. The CSV variant is a plain inventory of module names and version
numbers.

It was built to solve a real deployment headache: the enabled‑modules list getting
out of sync — or corrupted by missing files or folders — when moving a site between
dev, stage, and live, especially on large installs with a hundred or more modules.
It is also handy as a check tool (to verify which modules are enabled or disabled) and
in Git‑based workflows to track the enabled set across a push without writing enable
code in update hooks. It can even sync a module list across major Drupal versions
(for example D7 → D8), with limited functionality.

The module has no dependencies and one export form. There is nothing to leave
running — you generate an export, download it, and use it elsewhere.

> **One option to use carefully:** the version‑check feature writes a
> `hook_module_preinstall` into the generated module that *uninstalls*
> version‑mismatched modules on the target site. That is powerful — review the
> generated code before enabling it anywhere important.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is no ongoing configuration — the export form is the whole tool, and using it
is described below.

## Where it lives in the admin menu

The export form is at **`/admin/modules/export`** (route `module_export.settings`),
gated by the strong **Administer users** (`administer users`) permission.

## How to use it

1. Go to **`/admin/modules/export`**.
2. Choose your settings — whether to export all or only enabled modules, and the
   Drupal version of the **target** system.
3. Click **Export** and download the generated `.tar`/`.tar.gz` archive (or export
   the list as **CSV** instead).
4. Extract the archive and copy the generated module into the `modules` folder of the
   target Drupal site.
5. Enable it there — either by manually satisfying the listed dependency modules, or
   by letting Drush fulfil them automatically:

   ```bash
   drush en -y exported_module_name
   ```

The exported files contain only a module inventory (names, versions, and links) — no
secrets — and the generated machine name is sanitised, so the archive is safe to move
between environments.
