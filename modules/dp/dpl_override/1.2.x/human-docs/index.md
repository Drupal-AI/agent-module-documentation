# DPL Override — manual setup guide

**DPL Override** (`dpl_override`) is a near‑empty placeholder module. It ships
only an `.info.yml` file and a license — no routes, no services, no hooks, no
permissions, and no PHP classes. Enabling it registers the module with Drupal
but adds no functional behavior of any kind.

Its reason to exist is scaffolding and tooling: it appears to have been created
to verify module‑override or deployment behavior for a "DPL" distribution or
package. If you are here expecting a feature, there isn't one — this is a
smoke‑test target, not a user‑facing tool.

Because it holds no data and touches nothing at runtime, it is completely safe
to enable, disable, and uninstall. It leaves no residue behind.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form and
adds nothing to configure.

## Where it lives in the admin menu

DPL Override adds no admin page, no menu item, and no configuration link. Once
enabled it simply appears in the module list at **Extend**
(`/admin/modules`) as an enabled module, and does nothing else.

## How to use it

There is nothing to operate. Typical uses are all about tooling and process:

- Include it in a "DPL" package build to validate that your packaging and
  deployment pipeline registers a module correctly.
- Use it as a smoke‑test target for module override/deployment tooling.
- Clone it as a minimal starting scaffold for a real module.
- Confirm that enabling and uninstalling it leaves no config, permissions, or
  residual data behind.
