# Media Files Handler — manual setup guide

**Media Files Handler** (`media_files_handler`) is a behind‑the‑scenes housekeeping
module: it makes sure a media entity's files are handled correctly when the media
is updated, so you don't accumulate orphaned files. When a media item's source
file is replaced, the module checks whether the previous file is still used by any
revision or translation and acts accordingly — cleaning up files that are no longer
referenced instead of leaving them behind. It depends on Drupal core's File and
Media modules and runs on Drupal 9.3, 10, and 11.

There is nothing to configure and no page to visit: the behaviour applies
automatically once the module is enabled. In more detail, on each media update the
module works through the file lifecycle for you — a file still used by an older
revision is moved into private storage so it is no longer publicly accessible;
files of a published translation on the current revision are left untouched; a file
no longer used by any revision or translation is set to temporary or deleted; when
a published media entity is unpublished, its files move to private storage; and when
it is published, the current revision's files move back to public storage.

One thing to be aware of before enabling it: this is active development and the
module deliberately removes or relocates old files as media changes. That is the
intended behaviour, but if a file is shared or referenced somewhere outside the
media entity, confirm the module's handling matches your expectations. It has no
access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core's File and Media modules.

There is **no configuration page** for this module and nothing to set up — it works
automatically once enabled.

## Where it lives in the admin menu

Media Files Handler adds no admin page and no settings form. Its work happens
automatically whenever media entities are updated, unpublished, or published; you
simply enable it and let it run.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. That's all — from then on, updating, unpublishing, or publishing a media entity
   triggers the file cleanup described above. There is nothing to configure.

> **Before enabling on an existing site**, remember that the module will move old
> files to private storage or delete unreferenced ones as media changes. If any of
> your files are shared or referenced outside their media entity, verify this
> behaviour is what you want first.
