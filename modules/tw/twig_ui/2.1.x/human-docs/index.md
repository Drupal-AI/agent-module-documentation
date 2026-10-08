# Twig UI Templates — manual setup guide

**Twig UI Templates** (`twig_ui`) lets you create and manage Twig templates
directly from Drupal's admin interface, instead of editing `.html.twig` files in a
theme and deploying them. You give a template a **theme suggestion** to override
(for example `node__article` or `page__front`), paste in your Twig code, choose
which **theme(s)** it applies to, and enable it — and from then on it overrides the
matching file‑based template. Each template is stored as exportable configuration,
so overrides can be version‑controlled and moved between environments like any
other config.

Under the hood, when you enable a template the module writes your code to a real
`.html.twig` file and registers it with Drupal's theme system, so the theme engine
picks it up exactly as it would a template shipped in a theme. Only one enabled
template is allowed per theme‑suggestion + theme combination, which the add/edit
form enforces so overrides never conflict. Disabling or deleting a template
removes its file and reverts to the original template — no stale files left behind.

The admin screen lives at **Structure → Twig templates** and lets you add, edit,
clone, enable/disable, and delete templates. A separate settings form controls
which themes editors may target and can pass configuration to the optional
CodeMirror code editor for syntax highlighting. If the suggested **CodeMirror
Editor** module is installed, the template code field renders with line numbers
and highlighting.

> **Security — this is a trusted, developer‑level tool.** Anyone who can administer
> Twig UI templates can write Twig markup that the site renders. That is powerful:
> Twig can output arbitrary markup and, depending on the environment, reach into
> site internals. Treat the **Administer Twig templates** permission the same way
> you'd treat giving someone shell or Git access to the theme — grant it only to
> people you trust to write template code, never to general content editors. The
> module marks its permissions as *restricted* for exactly this reason.

It has no module dependencies (core 10 or 11) and optionally integrates with
**CodeMirror Editor**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and grant the (restricted) permissions.
2. [Configuration](configuration/index.md) — creating and managing templates, the
   fields on the template form, and the global settings form.

## Where it lives in the admin menu

- **Templates:** **Structure → Twig templates** (`/admin/structure/templates`) —
  the list of templates, plus add/edit/clone/delete.
- **Global settings:** **Configuration → System → Twig UI Templates**
  (`/admin/config/system/twig_ui`) — which themes are selectable and CodeMirror
  options.
