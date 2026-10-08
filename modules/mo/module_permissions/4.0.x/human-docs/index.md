# Module Permissions — manual setup guide

**Module Permissions** (`module_permissions`) lets a top‑level site administrator
define a **curated subset of modules** and then delegate the management of just
those modules to another role. Users in that delegated role can turn the selected
modules on and off, and manage those modules' permissions — but they cannot touch
any module outside the managed list. In effect it turns Drupal's all‑or‑nothing
*Administer modules* / *Administer permissions* into a governed, least‑privilege
capability.

The problem it solves is trust boundaries. Normally, giving someone the ability to
enable modules or grant permissions hands them the keys to the whole site. Module
Permissions lets you hand a site‑builder or client role a **safe, bounded** version
of that power: they manage the modules you have pre‑approved, and nothing else.

It ships one submodule, **Module Permissions UI** (`module_permissions_ui`), which
provides the administrative screen for curating the managed allow/deny list. The
base module provides the permissions and the enforcement; the UI submodule is what
you use to edit the list through the browser.

There is an important trust consideration, straight from the module's own
documentation, covered in [Configuration](configuration/index.md): whoever can edit
the managed list — and anyone granted the delegated management permission — is
effectively controlling the site's guardrails, so those capabilities must go only to
your most trusted operators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and the UI submodule).
2. [Configuration](configuration/index.md) — curate the managed module list, grant
   the delegated permission, and understand the privilege‑escalation caveats.

## Where it lives in the admin menu

Module Permissions works through Drupal's own permissions system. You grant the
delegated management permission at **People → Permissions**
(`/admin/people/permissions`), and you curate the managed module list through the
screen added by the **Module Permissions UI** submodule. See
[Configuration](configuration/index.md) for the details.
