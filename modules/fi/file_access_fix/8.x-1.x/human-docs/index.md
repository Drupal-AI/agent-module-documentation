# File Access Fix — manual setup guide

**File Access Fix** (`file_access_fix`) makes an attached file's storage location
follow its parent entity's **anonymous access**. It closes a well-known Drupal leak:
a file (image, document) attached to a non-public entity, but stored in the
**public** filesystem, remains directly downloadable by its URL even though the
entity itself is not viewable. This is the dilemma described in Drupal's
PSA-2016-003 — and it especially bites sites that accept anonymous uploads and want
to serve them performantly from public storage only *after* review.

The module resolves it by moving files between public and private storage based on
access. It checks each file's usages: if no using entity or field grants anonymous
access (and core's `hook_file_download` does not allow it either), the file is moved
to **private** storage; if anonymous access *is* allowed, it may live in public
storage. The net effect is that attached-file visibility tracks the parent entity's
anonymous-access state — so an unpublished node's image is no longer fetchable by
direct URL. It depends only on core's File module.

> **This module is deprecated.** The maintainers recommend the more feature-complete
> **[File Visibility](https://www.drupal.org/project/file_visibility)** module
> instead, and the long-term goal is to solve this in Drupal core (see the core
> issue referenced on the project page). Prefer File Visibility for new sites; use
> File Access Fix only if you already depend on it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and configure the private filesystem).

This module is an automatic **access-control** behavior with **no settings form** —
the important setup is on Drupal's side (a working private filesystem), described
below.

## Where it lives in the admin menu

File Access Fix adds no admin configuration page. It works automatically once
enabled, moving files as parent-entity access changes.

## How it works (the access model)

- The module looks at where a managed file is **used** — which entities and fields
  reference it.
- If **any** of those grant **anonymous** access (and core's file-download hooks
  permit it), the file can stay in **public** storage.
- If **none** do, the file is moved to **private** storage, where Drupal's
  access-checked file delivery decides who may download it. This is what prevents the
  classic "hidden entity's public image is still fetchable" leak.

Because it relies on private storage to actually enforce access, two things must be
true for it to protect anything: your **private filesystem must be configured**, and
private files must be served through Drupal's access-checked delivery (the default
for `private://`). After enabling, test the behavior against your real content
workflow — decide which entity states count as "anonymously accessible" on your
site and confirm files move as you expect.
