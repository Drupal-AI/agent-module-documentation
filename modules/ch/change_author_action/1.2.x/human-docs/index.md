# Change author action — manual setup guide

**Change author action** (`change_author_action`) adds a bulk **action** that
reassigns the author (owner) of many nodes — or media items — to a single chosen
user in one go. Instead of editing each node and changing its author by hand, you
tick the items on the content list, pick the *Change author* action, confirm the
new author, and the module updates them all in a background batch.

It is handy whenever ownership needs to move in bulk: an editor leaves the team,
content was imported under a service account and needs handing to real editors,
or a migration left authorship on the wrong user. Each change creates a new
revision, so the history is preserved, and items that already belong to the chosen
author are skipped.

The action is deliberately locked down. You can only select content you are
allowed to edit, and the confirmation step is gated by core's **Administer users**
permission — so only trusted administrators can actually perform the
reassignment.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   required Action module) and enable it.

## Where it lives in the admin menu

There is no settings page. The action appears in the bulk-operations dropdown on
the admin **Content** listing (`/admin/content`), and — because it also ships an
action for media — on the media list. Confirming a change happens on a dedicated
form at `/admin/change_author_action`, which requires the **Administer users**
permission.

## How to use it

1. Go to **Content** (`/admin/content`) and tick the nodes whose author you want
   to change. (You can only select content you are permitted to edit.)
2. In the **Action** dropdown choose **Change author**, then apply it.
3. **Step 1 — choose the new author:** start typing a username in the autocomplete
   field and select the target account. (The anonymous user is excluded.)
4. **Step 2 — confirm:** the form lists the titles of the items that will change.
   Review them and confirm.
5. The module runs a batch that reassigns each item, creating a new revision for
   each and skipping any already owned by the chosen user.

To change authorship of **media** instead of nodes, use the same *Change author*
action from the media list.

### Notes

- Only users with core's **Administer users** permission can complete the confirm
  form — a lower-privilege user who somehow triggers the action is stopped there
  with access denied.
- The batch processes large selections in chunks, so it won't time out on big
  reassignments.
- Advanced: the module ships one action plugin used by two shipped action configs
  (one for nodes, one for media). Developers can register the same action for
  another entity type by cloning a `system.action.*` config — see the
  [`agent/`](../agent/start.md) docs.
