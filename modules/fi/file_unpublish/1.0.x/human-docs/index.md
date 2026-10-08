# Unpublish Public Files — manual setup guide

**Unpublish Public Files** (`file_unpublish`) closes a well-known gap in editorial
workflows: when an editor unpublishes a media item, the file behind it can still be
downloaded directly by its URL. By default, files stored in the **public** file
system (the `public://` wrapper) are served straight from the web server at
addresses like `https://example.com/sites/default/files/my-file.pdf`, and Drupal
never gets a chance to check whether the surrounding media is published. This module
makes those public files become **unavailable** while their parent media is
unpublished, and available again once it is republished.

It does this without moving files around or forcing everything into the private
file system (which makes Drupal process every download and can become a
performance bottleneck). Instead, it keeps public files public and **outsources the
access check to the web server**. When a media entity is unpublished, the module
drops a small empty **marker file** next to the original — same name plus a
configured extension such as `.x410` (so `my-file.pdf` gets a companion
`my-file.pdf.x410`). A short web-server rule checks for that marker on every file
request and refuses to serve the file (returning an HTTP *410 Gone*) when the
marker is present. When the media is published again, the module removes the marker
and the file serves normally.

That web-server rule is the one piece you must add by hand — see
[Installation](installation/index.md). The module depends on core **Media** and
**File**, targets **Drupal 10.4+ and 11**, provides its own permissions, and is
currently a release candidate (`1.0.0-rc1`). Note it is **not covered by Drupal's
security advisory policy**, so review it against your own risk tolerance before
relying on it in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and add the required web-server configuration snippet.

There is **no Drupal settings form** to click through — the behavior is automatic
once the module is enabled and the web-server rule is in place. The marker-file
mechanism and the required web-server snippet are covered in Installation.

## Where it lives in the admin menu

Unpublish Public Files has no admin settings page. It works in the background,
reacting to media publish/unpublish events by creating or removing marker files. Its
permissions appear on the standard **People → Permissions** page.

## How to use it

Once installed and the web-server rule is in place, there is nothing extra to do
day to day: unpublish a media item and its underlying public file stops serving
(returns *410 Gone*); publish it again and the file serves normally. "Media entity
files" here means all files referenced by that entity via its file fields.
