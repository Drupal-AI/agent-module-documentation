# Move File — manual setup guide

**Move File** (`move_file`) automatically relocates the files attached to a node
into a target folder chosen by the node's **taxonomy term**, whenever the node is
saved. You define a mapping — "term X → this directory (public or private)" — and
from then on, when an editor picks a term on a node and saves, the files in that
node's file fields are moved to the matching folder. Change the term and save
again, and the files move to the new folder. It turns editorial taxonomy into an
automatic filing system for uploads.

A common use is **dynamic file permissions**: paired with the
[Private files download permission](https://www.drupal.org/project/private_files_download_permission)
module, moving a file between a public and a private directory effectively changes
who can download it — so re-categorising a node can, for example, move a document
into private storage for a restricted group. It works across multiple file and
image fields on a content type, and you enable the behaviour only for the content
types you choose.

Under the hood, Move File defines a `move_file_directory` configuration entity
that maps a taxonomy term to a directory (a path plus a public/private scheme
flag). On node insert and update it checks whether the content type is enabled,
reads the selected term(s) from the configured vocabulary field, finds the
matching directory, and moves each file there (only when the destination actually
differs from the current location). It supports **Drupal 9.1 and 10**.

Directory paths and the term-to-directory mapping are **admin-defined**. Treat the
`administer move_file` permission as a trusted-administrator permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose which content types and
   fields it acts on, and map each term to a destination directory.

## Where it lives in the admin menu

Once enabled, all of Move File's configuration lives under
`/admin/config/media/move-file` (route `move_file.settings`), gated by the
`administer move_file` permission. See [Configuration](configuration/index.md).
