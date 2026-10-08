# Revision Menu Trail — manual setup guide

**Revision Menu Trail** (`revision_menu_trail`) fixes the active menu highlight and
breadcrumb when you view an entity **revision**. Normally, when an editor previews
an older revision or the "latest revision" of a moderated node, Drupal does not set
the active menu trail based on that revision, so the menu highlighting and
breadcrumb can be wrong or missing. This module sets the active trail according to
the current revision on revision paths — including the *latest revision* tab
provided by the Content Moderation module — so the surrounding navigation (menu
blocks, breadcrumb) matches what the editor is looking at.

The practical benefit is a better **preview**: because the menu trail is correct,
menu blocks render alongside the revision as they would on the live page, giving
editors a truer sense of how their latest revision will appear in context.

This is a small content-display/navigation fix. It affects only the active trail on
revision routes — it does not change content or access, and core's revision
permissions still govern who can view revisions. There is nothing to configure.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** and no setup — the fix applies as soon as the
module is enabled.

## How to use it

1. Enable the module — there is nothing to configure.
2. View an entity revision, or the **Latest version** tab of a moderated node. The
   active menu trail and breadcrumb now reflect that revision, so menu blocks
   displayed alongside it highlight correctly.
