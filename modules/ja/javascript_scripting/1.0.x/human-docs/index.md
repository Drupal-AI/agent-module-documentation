# Javascript Scripting — manual setup guide

**Javascript Scripting** (`javascript_scripting`) adds a JavaScript engine that
lets you execute scripted logic inside Drupal without writing a full module. The
idea is modelled on spreadsheet formulas: you author a small JavaScript snippet in
a **script field**, it processes input parameters, and it produces an explicit
output — the way a formula in a spreadsheet cell turns inputs into a result.

Under the hood the module transpiles the JavaScript into PHP and runs it
**server‑side**, using Drupal's Twig‑like caching to keep execution efficient. It
deliberately disallows importing or running external JavaScript, keeping execution
tightly scoped. Scripts can also be run from the command line with the
`javascript:execute` Drush command.

## Please read this before enabling: a security warning

Executing code is a **privileged capability**, and it must be treated like
Drupal's PHP/scripting tools. **Anyone who can edit a script field — or run
Drush — can execute code on your server.** That makes *script authoring itself*
the trust boundary. Follow these rules:

- Grant the module's execution permission and edit access to the script field
  **only to fully trusted roles** (administrators / developers).
- **Never** place a script field on content, forms, or entities that untrusted or
  anonymous users can edit — doing so would hand them arbitrary code execution.
- Review scripts the way you would review custom module code before they run in
  production.

If you are not comfortable with those constraints, do not enable this module on a
public or multi‑author site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has no central settings form. It works through a **script field** you
add to an entity (with an accompanying execute action) and the
`javascript:execute` Drush command — see "How to use it" below.

## How to use it

1. Add a **script field** provided by the module to a bundle whose editing you
   restrict to trusted roles (**Structure → Content types → *(bundle)* → Manage
   fields**).
2. Author your JavaScript snippet in that field. Keep the logic to processing
   inputs and returning an explicit output.
3. Run it either through the field's **execute action** in the UI, or from the CLI
   with `drush javascript:execute` (inside DDEV: `ddev drush javascript:execute`).
4. Confirm that the permission controlling execution, and edit access to the
   script field, are granted only to the trusted roles you intend.
