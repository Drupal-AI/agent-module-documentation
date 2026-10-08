# Devel — manual setup guide

**Devel** (`devel`) is a developer toolkit for Drupal: a collection of blocks,
pages, and helper functions that make debugging and inspecting a running site
easier. It lets you dump PHP variables to the screen or a log file, install
richer error handlers, generate dummy content, switch to any user account with
one click to test permissions, and browse introspection pages that list every
route, service, event, entity type, and container parameter the site exposes.
Devel defines a pluggable *variable dumper* backend (Symfony VarDumper by
default, or Kint when its library is installed) and ships Drush commands and a
raw configuration editor for developers.

Devel is packaged with useful companions: the bundled **Devel Generate**
submodule creates bulk test nodes, users, terms, and menus, and separate
projects such as **Webprofiler** add a performance/inspection toolbar. This
guide is written for a **human** clicking through the admin UI — it walks you
from installing the module to tuning the Devel settings page. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **This is a development tool.** Devel exposes sensitive internals and debug
> output. Enable it on local and staging environments only — **do not enable
> Devel on a production site.**

![The Devel settings page under Configuration → Development](images/settings.png)

## Where it lives in the admin menu

Devel's main configuration screen is at **Configuration → Development → Devel
settings** (`/admin/config/development/devel`). Once the module is enabled you
will also find:

- A **Settings** tab (shown above) and a **Toolbar Settings** tab for choosing
  which Devel links appear in the toolbar.
- A **Devel** menu/toolbar with quick actions (clear cache, rebuild router,
  reinstall modules, config editor) when the core Toolbar is enabled.
- A **Switch user** block you can place to become another account.
- Introspection pages for routes, services, events, entity types, elements,
  layouts, and the service container.

## Contents

1. [Installation](installation/index.md) — install Devel with Composer as a dev
   dependency, enable it, and add the useful submodules.
2. [Configuration](configuration/index.md) — walk through the Devel settings
   page: error handlers, the variable dumper, the debug log file, and more.
