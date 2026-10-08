# Content Moderation Edit Notify — manual setup guide

**Content Moderation Edit Notify** (`content_moderation_edit_notify`) protects
editors from silently clobbering one another's work on moderated content. When two
people edit the same moderated entity at the same time, whoever saves second can
either be blocked by Drupal's "content has been modified by another user" error — or,
worse, quietly create a new revision that buries the first editor's changes. This
module warns the editor **before** that happens.

While you have a moderated content item open for editing, the module quietly checks
in the background — on a regular interval (30 seconds by default) — whether a newer
revision has been saved by someone else. If it detects that your revision is now
out of date, it shows a message at the top of the form, above the save button, so
you can decide what to do before you save and risk overwriting or losing changes.
It's a visual, in-form warning; there's nothing to open or check elsewhere.

This is an editorial-workflow convenience with no unusual security surface — it only
surfaces information about editorial activity to the editors already working on the
content. It builds on core **Content Moderation** and **Workflows** (and core Node
and Filter).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is no dedicated global settings page for the module. The check interval
defaults to 30 seconds and can be adjusted; otherwise the warning works as soon as
the module is enabled.

## How to use it

There's nothing to click to turn it on beyond enabling the module. Once enabled,
open a moderated content item for editing. If another user saves a new revision of
that same content while you're still in the form, a message appears at the top of
the form, before the save button, alerting you so you can avoid overwriting their
changes — for example by reloading and reconciling before you save.
