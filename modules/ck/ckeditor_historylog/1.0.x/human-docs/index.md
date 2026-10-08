# CKEditor Autosave History Log — manual setup guide

**CKEditor Autosave History Log** (`ckeditor_historylog`) adds a History Log button
to the CKEditor 5 toolbar that lets an editor roll back to an earlier autosaved
version of what they were writing. As someone types, the plugin periodically saves
the editor's content to the **browser's local storage**, keeping a short revision
history per editor instance — so each editor on a page has its own history. If the
browser crashes, the tab closes, or a long article suddenly disappears, everything
in the editor can be recovered from the button's history log.

It is meant as a disaster‑recovery safety net rather than a full versioning system:
by default it only holds revisions for up to about a day. It depends on core
CKEditor 5 and has no settings page of its own.

> **Privacy note.** Because drafts are stored in the browser's local storage, the
> content persists in that browser until it is cleared. On a **shared or public
> computer** this means someone's in‑progress draft can linger for the next person
> to use the machine — worth keeping in mind for sensitive content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You turn the History Log button
on per text format, described under "How to use it" below.

## How to use it

Add the button to each text format where you want autosave recovery:

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Click **Configure** next to a format that uses CKEditor 5.
3. In the CKEditor 5 toolbar configuration, drag the **History Log** button from
   the *Available buttons* tray into the *Active toolbar*.
4. Click **Save configuration**.

When editing content in that format, the plugin autosaves to your browser's local
storage as you work; click the History Log button to view and restore an earlier
autosaved revision.
