# Component Library — manual setup guide

**Component Library** (`component_library`) lets you build a library of reusable
UI components and treat theming as a site-building task. Components hold their own
markup/templates and can be edited right in the browser using a **CodeMirror**
code editor — with an "Override Mode" that lets you edit Twig templates and add
CSS and JS in the browser, then publish the changes. Components can be reused
across the site and placed with **Layout Builder**, and there is optional
integration for embedding component variants inside CKEditor 5 content.

It depends on the **Entity API** (`entity`), the **CodeMirror Editor**
(`codemirror_editor`), and core **Layout Builder** (`layout_builder`). It
provides its own permissions and ships optional submodules — an engine
submodule, a Workspaces submodule for publishing component changes alongside a
workspace, and a Group submodule (requires the Group module) for per-group
component/variant selection.

**A security note worth reading before you enable it:** components can contain
markup and template code, which means whoever can create or edit them holds a
powerful capability — a malicious or careless component could inject markup or
JavaScript into pages. Treat the component-editing permissions as
developer/site-builder–only and grant them to trusted users. The module has no
access-control role beyond its own permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its dependencies, and pick the submodules you need.

There is **no single settings form** for this module — you create and edit
components through its component-management UI (with CodeMirror), and place them
via Layout Builder.

## Where it lives in the admin menu

Component Library adds a component-management interface where you create and edit
your components in the browser (using the CodeMirror editor), and the components
you build become available to place through **Layout Builder**. Before using it,
grant the component-editing permissions at **People → Permissions** to trusted
roles only — see the security note above.
