# File Visibility — manual setup guide

**File Visibility** (`file_visibility`) closes a well-known information leak: a file
attached to an entity that isn't publicly viewable — an unpublished node, say — is
still **directly downloadable by URL** when it lives in the public file system, even
though the entity itself is hidden. The classic case is an unpublished node whose
public image can still be fetched, which spammers can exploit to manipulate search
engines. File Visibility fixes this by keeping such a file in the **private** file
system while its entity is not publicly accessible, and moving it to the **public**
file system only once public content actually uses it. In short, **file access
follows entity access**.

It's deliberately smarter than "just make everything private." Forcing all uploads
private makes Drupal, PHP, and the web server process every single download, which
becomes a bottleneck under heavy traffic; public files, by contrast, are served
directly and usually come from a cache. So File Visibility keeps a file public
*whenever at least one publicly visible piece of content uses it*, and moves it to
private only when no anonymous-visible path to it remains.

To work out those relationships, the module walks the **path** from a *source
entity* (the content a visitor could see) through any *traversable entities* in
between (paragraphs, media, and so on) to the file itself, checking visibility at
each step. It provides a **FileVisibility plugin type** for this, but ships **no
plugin on its own** — you need one that knows how to compute file-to-entity
relationships. The bundled **`file_visibility_track_usage`** submodule provides such
a plugin by drawing on the contributed **Track Usage** module; third-party modules
can supply their own plugins instead.

This is a positive security feature. It depends on core **File**, targets **Drupal
10.4+ and 11**, and is currently an **alpha** release (`1.0.0-alpha9`) — test it
against your content workflow before relying on it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, choose how it computes file usage (the submodule), and confirm the private
   file system is configured.

There is **no standalone settings form** in the main module. When you use the
`file_visibility_track_usage` submodule, the relevant configuration is done in the
**Track Usage** module (which entity types and fields to track). This is described in
Installation.

## Where it lives in the admin menu

File Visibility adds no settings page of its own; it works in the background, moving
files between the public and private file systems as entity visibility changes. When
using the tracking submodule, you configure *what* is tracked through the **Track
Usage** module's own settings.

## How it works, in practice

1. A visitor-facing (source) entity references a file — directly, or through
   traversable entities like paragraphs or media.
2. The module follows every path from source entities to the file and checks whether
   each step is visible to anonymous users.
3. If **at least one** fully anonymous-visible path exists, the file is treated as in
   use and kept **public**. If no such path exists, the file is moved to the
   **private** file system, out of direct-URL reach.
