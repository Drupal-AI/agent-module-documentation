# Config Enforce - Devel — manual setup guide

**Config Enforce - Devel** (`config_enforce_devel`) is the **development companion**
for [Config Enforce](https://www.drupal.org/project/config_enforce). Config Enforce
makes selected configuration read-only in production; this module gives developers
the convenient UI to decide, for each config object on the site, **whether and how
strictly** to enforce it — and it streamlines writing the resulting config YAML
files into your codebase so the enforcement travels with your code.

> **Do not install this module in production.** It is a developer tool for marking
> and managing enforced configuration during site building. On production you run
> Config Enforce alone; the enforcement decisions this module helps you author are
> already baked into your committed config files by then.

Because it is purely a development helper, it builds on a small stack of related
modules: **Config Enforce** (the runtime enforcement it configures), **Config
Devel** (`config_devel`, which handles writing active config back out to files),
and **Multiselect** (`multiselect`, used for its selection UI). It supports Drupal
10.1+ and 11. Its admin screens are gated by the core **Administer site
configuration** permission (it does not define a permission of its own).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install (in development only) with
   Composer and enable it alongside its dependencies.

Its screens live under **Configuration → Development → Config Enforce**
(`/admin/config/development/config_enforce`), added as tabs alongside Config
Enforce. The main pages are a **Config Enforce Devel settings** form (defaults for
enforcement, the list of available target modules, and an ignore list) and an
**Enforced configs** page (review what is enforced, generate settings in bulk, and
add a new target module). Individual config forms across the site also gain an
enforcement indicator with a **Manage settings** button. The workflow is described
below.

## Where it lives in the admin menu

This module adds development-only controls under **Configuration → Development →
Config Enforce**. Because it is meant strictly for development environments, treat
its UI as a build-time tool, not a production admin page.

## How to use it

1. Install this module **and** Config Enforce in your development environment (see
   [Installation](installation/index.md)). Make sure Composer patching is enabled,
   as Config Enforce requires it.
2. Use the UI to go through your config objects and mark which ones to enforce, and
   choose the strictness (read-only form, block database writes, re-import from
   disk).
3. Let the module write the enforcement metadata into your config YAML files, then
   commit those files to your codebase.
4. Deploy to production with **Config Enforce enabled but this Devel module
   removed/disabled**. The enforcement you authored here is now in force from code.
