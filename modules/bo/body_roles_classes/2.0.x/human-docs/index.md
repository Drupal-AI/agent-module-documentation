# Body Roles Classes — manual setup guide

**Body Roles Classes** (`body_roles_classes`) adds CSS classes to the HTML `<body>`
element based on the **current user's roles**, so your theme and CSS can style the
site differently depending on who is looking at it — without writing a preprocess
hook yourself. For each of the visitor's roles it emits one class (for example
`role-editor`), and it always adds either `user-authenticated` or `user-anonymous`
so you can also style by login state.

Each class is built from a configurable **prefix** (default `role-`) plus the role,
then normalised into a valid CSS identifier (lowercased, underscores turned into
hyphens). You can **exclude** roles you don't want exposed in the front‑end markup —
the sensitive `administrator` role is excluded by default — and you can **rename** the
class emitted for any role with a per‑role map (for example map `content_editor` to
just `editor`). The output is cache‑aware: it varies by the user's roles, so it stays
correct as different users view the page.

Typical uses are showing or hiding front‑end UI by role with CSS only, giving a
"member" or "premium" role a distinct look, driving JavaScript behaviour off a body
class, or prototyping role‑gated visual states during design and QA. The module has
no external dependencies and no Drush commands.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is a small settings form at **Configuration → User interface → Body Roles
Classes** (`/admin/config/user-interface/body-roles-classes`). See the caveat below —
in this version only user 1 can reach it, because it requires a permission the module
does not actually define.

## How to use it

Once enabled, the module works immediately: role classes appear on `<body>`, and you
can start targeting them in your theme's CSS (e.g. `body.role-editor { … }`). To tune
its behaviour, use the settings form (or Drush — see the caveat):

- **Enable** — a master switch. When off, no classes are added.
- **Class prefix** — prepended to each role class before it is cleaned up. Default
  `role-`. Use a distinctive prefix to avoid colliding with other body classes.
- **Exclude roles** — roles to leave out of the output. Useful for hiding sensitive
  roles from the front‑end HTML; **`administrator` is excluded by default**.
- **Role map** — a per‑role override of the emitted class name (e.g. `content_editor`
  → `editor`). This one is **not** editable in the form; set it via configuration
  (Drush `config:set` or a config import).

Alongside the role classes, `<body>` always gets `user-authenticated` or
`user-anonymous`.

### Setting values with Drush

Because of the permission caveat below, the reliable way to manage settings on this
version is Drush:

```bash
ddev drush config:set body_roles_classes.settings prefix 'r-' -y
ddev drush config:set body_roles_classes.settings enabled 1 -y
```

### Caveat: the settings form's permission

The settings route requires a permission (`administer body roles classes`) that the
module **does not actually define** — it ships no permissions file. As a result the
permission can't be granted to any role, so out of the box only **user 1** (the
superuser, who bypasses permission checks) can open the form. If you are not user 1,
manage the configuration with Drush or a config import as shown above.
