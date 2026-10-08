# Module Manager — manual setup guide

**Module Manager** (`module_manager`) lets you search, install, update, and remove
contributed modules from **Drupal.org directly through the site's administrative
interface** — no shell or Composer access required. When you install a module, it
downloads the release ZIP from Drupal.org, validates it with Composer, extracts it
into your codebase, and enables it, all from the browser.

Its routes are gated by core's **Administer modules** permission, and it lists a
"Module Manager" screen where you browse and filter available modules by category,
view a module's details and releases, and install or remove them. It only lists
modules that have security coverage, a stable release, and compatibility with your
Drupal version, and it validates dependencies before installing.

> **This is a powerful, code‑execution‑capable capability — treat it with the same
> caution as core's web‑install flow.** Installing a module means adding executable
> code to the running site, so any compromise of an account with *Administer modules*
> becomes arbitrary code execution, and it **bypasses your controlled deployment
> pipeline** (Composer/CI, code review, lock files). It also downloads archives from
> the network, so supply‑chain trust matters. Keep *Administer modules* restricted to
> fully‑trusted administrators, prefer **Composer‑based deployment** for production,
> and use Module Manager deliberately — ideally only in non‑production contexts. On
> hardened sites you may even want the opposite (see the `disable_web_install`
> module, which blocks web installs entirely).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and prepare the writable extraction folder it needs.

There is no settings form; you operate Module Manager entirely from its admin screen,
described below.

## Where it lives in the admin menu

After enabling, look for **Module Manager** in the administration menu. From there you
search and filter Drupal.org modules, open a module's details, and install or remove.

## How to use it

1. Complete [Installation](installation/index.md), including creating the writable
   `modules/module_manager_contrib` folder — extraction fails without it.
2. Open **Module Manager** from the admin menu.
3. Use the search box and category filters to find a compatible module.
4. Click **View** on a module, then **Install** on the version you want. Module
   Manager downloads the release, validates dependencies, extracts it, and enables
   it.
5. To remove a module, use the **Remove module** option on its details screen.
6. The "list modules installed via Module Manager" view shows what you have added
   through this tool.
