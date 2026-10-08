# Publication Scheduler — manual setup guide

**Publication Scheduler** (`publication_scheduler`) is a small "glue" module that
makes the **Publication Date** and **Scheduler** modules work together more
smoothly. On their own, the two overlap awkwardly: Scheduler lets you set a
*publish on* date so content goes live automatically, while Publication Date
records the moment a node was first published. Publication Scheduler tidies up the
editing experience so those two features feel like one coherent workflow — and so
scheduled content ends up with an accurate publication date (the moment it
actually went live) rather than its creation date.

Concretely, on the node add/edit form the module:

- **Hides the "Authored on" (Created) field** — because you now have a proper
  *Published on* field from Publication Date, there's rarely a need to edit the
  creation date. This can be turned back off in the module's settings, and a
  permission lets you allow certain roles to keep editing it.
- **Hides the "Published" checkbox** when Scheduler's *Require scheduled
  publishing* option is enabled, so editors can't bypass the schedule.
- **Turns the "Published" checkbox into radio buttons** with clearer,
  more meaningful labels.
- **Shows the "Publish on" scheduling field only** when you've chosen to keep the
  content unpublished — keeping the form uncluttered.

The result is a cleaner, less error‑prone editing form for teams that schedule
content and care about accurate publication dates.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Publication Date and Scheduler dependencies.
2. [Configuration](configuration/index.md) — the optional "Authored on" toggle
   and the module's permissions.

## Where it lives in the admin menu

Publication Scheduler mostly works automatically once its dependencies are set
up — its effects appear directly on the **node add/edit form**. It doesn't add a
prominent top‑level configuration page; its adjustable behavior comes down to one
optional setting and two permissions, both covered in
[Configuration](configuration/index.md).
