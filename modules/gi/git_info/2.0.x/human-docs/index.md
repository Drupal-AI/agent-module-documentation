# Git Info — manual setup guide

**Git Info** (`git_info`) surfaces information about the exact revision of the
code that's deployed to a site. It can show the current **Git tag**, the **commit
revision (hash)**, the **date of the last commit**, or any combination of those.
That's handy for knowing precisely which version of your product is running on a
given server, and for attaching that version string to bug reports so issues can
be tied back to specific code.

It exposes this information in two ways: a **block** you can place in a region,
and **tokens** you can use anywhere tokens are supported. (This is the same
mechanism that powers the version string on Violinist.io.)

> **Important security note:** the deployed branch and commit are useful
> operational details, but they also reveal information about your infrastructure.
> **Do not expose this publicly.** Restrict the block and any token output to
> trusted, authenticated users — for example place the block only in an
> admin‑facing region, or restrict it by role — rather than showing it to
> anonymous visitors.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central settings form** for this module. You configure what shows
where when you place the block (through the Block Layout UI) or when you insert
the tokens — described in "How to use it" below.

## Where it lives in the admin menu

Git Info adds no settings page of its own. You work with it through:

- **Structure → Block layout** (`/admin/structure/block`) — to place the Git Info
  block into a region and set its visibility.
- Any token‑enabled field or template — to print the tag, revision, or last‑commit
  date via the module's tokens.

## How to use it

1. **As a block:** go to **Structure → Block layout**, click **Place block** in
   the region you want, and choose the Git Info block. Configure its visibility so
   it is shown only to trusted roles or on admin pages — not to anonymous users.
2. **As tokens:** use the module's Git tokens (tag, commit revision, last‑commit
   date) wherever tokens are available, again taking care not to render them to
   the public.

Because the point of the module is to identify a deployment, keep the output where
your team can see it and the public cannot.
