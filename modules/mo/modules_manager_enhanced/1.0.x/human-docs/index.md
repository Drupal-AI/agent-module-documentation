# Modules Manager Enhanced — manual setup guide

**Modules Manager Enhanced** (`modules_manager_enhanced`) transforms the default
Drupal modules administration page (`/admin/modules`) into a faster, more organised
interface by adding **package‑based filtering** with server‑side performance
optimisation. If you have ever waited for the Extend page to load on a site with many
contributed modules, or struggled to find specific modules in a long list, this is the
module for that.

It adds a **"Filter by Package"** section at the top of `/admin/modules`. By default
only the **Core** and **Administration** packages are shown — which is what makes the
page faster — and you use a dropdown to reveal additional packages, then click **Apply
Filter**. A **Reset Filter** button returns to the default view. The URL updates to
reflect your selection, so you can bookmark a specific filtered view. Under the hood an
EventSubscriber intercepts the request and pre‑filters the module list before the form
is built, cutting server processing time and memory use on large installs.

Importantly, this module only **alters the modules‑list UI** — it does not download or
install code from the web. It depends on core's System module and requires the
**Administer modules** permission to see the enhanced interface (and JavaScript enabled
in the browser for the filtering controls).

> **No configuration is required.** The module works immediately on enable; the only
> customisation (changing the default packages) requires editing the code and is for
> advanced users, so there is no settings form.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

There is no configuration page — usage is described below.

## Where it lives in the admin menu

Modules Manager Enhanced adds no page of its own. Its **Filter by Package** controls
appear at the top of the core **Extend** page (`/admin/modules`).

## How to use it

1. After installing (see [Installation](installation/index.md)), go to
   **`/admin/modules`** as a user with the **Administer modules** permission.
2. You'll see a **Filter by Package** section at the top. By default only **Core** and
   **Administration** are shown.
3. Use the dropdown to select additional packages, then click **Apply Filter** to
   update the view. The URL changes to match, so you can bookmark it.
4. Click **Reset Filter** to return to the default view.
