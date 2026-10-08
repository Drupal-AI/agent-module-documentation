# Content Moderation Tabs — manual setup guide

**Content Moderation Tabs** (`content_moderation_tabs`) makes it easy to add
tabs to the **Content** administration page for different content-moderation
states — an "In progress" tab for drafts, a "Needs signoff" tab for content in
review, and so on — sitting alongside the standard **Content → Overview** sub-tab.
Instead of hunting through one big moderated-content list, editors get a dedicated
tab per state that opens the View you point it at.

What makes this module pleasant is *where* you configure it. Rather than a
separate settings page, the options live right on each workflow state's edit form.
While editing a Content Moderation workflow state you can toggle whether it should
have a tab, set the tab's title (it defaults to the state's label), set its weight
to control ordering in the Content submenu, and choose which View the tab should
open. It's a purely editorial-UX feature: moderation access still follows core
Content Moderation's own permissions, and the module adds no access-control of its
own. It depends on core's **Content Moderation** module.

A couple of things are still in progress at this early stage: a fallback,
non-Views listing for each configured state is present but not auto-configured
yet, and a setting to remove the core "Moderated content" tab entirely is planned
but not implemented. The **Workflow Buttons** and **Trash Workflows** modules make
good complements.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note:** This is an early release (1.0.0-alpha1) requiring Drupal 11.1 or newer.
> Evaluate it before relying on it in production.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no standalone configuration page** — you configure tabs directly on
each workflow state, described in "How to use it" below.

## Where it lives in the admin menu

The tabs you create appear under **Content** (`/admin/content`), next to the
standard Overview and Moderated content tabs. You configure them from
**Configuration → Workflow → Workflows** (`/admin/config/workflow/workflows`) by
editing individual workflow states.

## How to use it

1. Make sure core's **Content Moderation** module is enabled — it creates a
   default Editorial workflow unless you install a recipe that substitutes a
   different one.
2. Go to **Configuration → Workflow → Workflows**
   (`/admin/config/workflow/workflows`).
3. Edit a workflow state (create some first if you don't have any). The workflow
   must be of the **Content Moderation** type.
4. Tick **Enable tab**.
5. Set the **tab name** you want (it defaults to the state label).
6. Set the **view route** the tab should open, and/or override the fallback
   non-view route, and set a **weight** to control where the tab sits in the
   Content submenu.
7. Press **Save**.
8. Repeat for each moderation state you want a tab for. The new tabs then appear
   under **Content**.
