# Prevent User Delete Reassign — manual setup guide

**Prevent User Delete Reassign** (`prevent_user_delete_reassign`) does one small,
deliberate thing: it removes the **"Delete the account and make its content belong
to the Anonymous user"** option from Drupal's account cancellation forms — both the
single‑user form at `/user/{user}/cancel` and the bulk form at
`/admin/people/cancel`.

That option (internally `user_cancel_reassign`) is the quietly destructive one. It
keeps every node, comment, and file the user created but reassigns their author to
*Anonymous* — so the content survives while the record of who wrote it does not.
Nothing warns that this is irreversible, and it is: reconstructing authorship from
revisions afterwards is at best partial. The consequences tend to land later — an
editorial site loses attribution across hundreds of articles, a site with an audit
obligation loses its accountability trail, and a site that relies on "edit own
content" permissions discovers that nobody owns anything, so nobody can edit it.
There is also an open core bug where old revisions by the cancelled user can be
republished as the current version of a node, which is what prompted this module.

By removing the option, the module forces a deliberate choice among the safer
alternatives Drupal still offers: **disable** the account, **delete the account and
its content**, or **reassign authorship to a named archive account** (which keeps
content editable and honest about no longer being that person's work).

> **It's worth noting** that this is *not* the GDPR erasure answer people sometimes
> reach for it with — anonymising the author link while keeping content that names
> the person in its text has not actually removed their personal data.

There is nothing to configure — enabling the module removes the option.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — the module has no settings. See "How to use
it" below.

## How to use it

Enable the module; the change is immediate. When an administrator visits either
cancellation form, the "…make its content belong to the Anonymous user" choice is
simply no longer listed, leaving the safer methods to choose from.

> **Check the API path too.** Removing a UI option does not constrain code. If your
> site has scripts or `drush user:cancel` invocations that pass the
> `user_cancel_reassign` method explicitly, they will still perform the reassign —
> review and update those separately.
