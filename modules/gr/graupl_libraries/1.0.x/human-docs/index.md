# Graupl Libraries — manual setup guide

**Graupl Libraries** (`graupl_libraries`) is a small building-block module: it
bundles the **Graupl** accessible-menu JavaScript library and makes it available
to other modules and themes as a shared dependency. Graupl provides keyboard- and
ARIA-accessible dropdown menus, and this module is how the rest of the Graupl
ecosystem (and any theme you write) gets hold of that library without shipping
its own copy.

There is nothing to click and nothing to configure. You rarely install this
module on its own for its own sake — instead, another module or theme that uses
Graupl-based menus declares a dependency on it, and Drupal enables it as part of
that. It has no content model, no settings, and no access-control role; it is
purely a front-end library provider.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — it only provides libraries
for other modules and themes to use.

## How to use it

Enable the module (usually it comes in automatically as a dependency of a
Graupl-based module or theme). Then, from a custom module or theme that needs
accessible Graupl menus, declare a dependency on the library it provides in your
`*.libraries.yml` / `*.info.yml`. From a site-builder's point of view there is
nothing further to do here — the visible functionality lives in whatever module
or theme *consumes* this library, such as Graupl Components.
