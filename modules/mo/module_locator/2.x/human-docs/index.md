# Module Locator — manual setup guide

**Module Locator** (`module_locator`) is a small developer diagnostic that shows the
**filesystem path (location) of each module** directly on the module list page. It
answers the everyday question "where on disk is this module actually installed?"
without dropping to a shell.

It is especially handy on **legacy projects** where modules ended up in unexpected
places, and on **multisite installations** where the same module name might resolve
to different directories. There is nothing to configure — enable it and the paths
appear.

> Module inventory and paths are mild reconnaissance information, so keep this tool
> admin‑gated and don't expose it to untrusted users. Because it is a developer aid,
> many teams enable it only on development environments.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is no settings form — the module works the moment you enable it.

## Where it lives in the admin menu

Module Locator adds no admin page of its own. Once enabled, go to **Extend**
(`/admin/modules`) and you will see each module's filesystem path shown alongside it.
