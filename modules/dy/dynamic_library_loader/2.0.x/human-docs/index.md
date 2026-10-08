# Dynamic Library Loader — manual setup guide

**Dynamic Library Loader** (`dynamic_library_loader`) gives you a UI for **attaching
specific asset libraries (CSS/JS) to specific entities** — so a library only loads
where it's actually needed, rather than being always on. Have a paragraph with CSS/JS
that's only relevant to that paragraph? Point the module at it and the library is
attached only when that paragraph appears.

The reason to use this instead of attaching a library from a Twig template is
**timing**. Attaching in Twig can be hit‑or‑miss because it happens *after* the global
CSS has been aggregated, which leads to odd results like styles not rendering. Dynamic
Library Loader attaches the library while global libraries are being aggregated,
sidestepping that problem and keeping the front end predictable — and it keeps
always‑on assets off pages that don't need them, which helps performance.

You manage everything from an admin form. It currently supports attaching libraries
to **content types, taxonomy vocabularies, views, and paragraphs**. Note that this is
a **developer/theming** feature — the libraries you attach are declared libraries you
(or a module/theme) have defined, so it has no bearing on content or access control.
Earlier versions depended on the Paragraphs module, but that's no longer the case; the
module stands on its own on Drupal 10 and 11 (and works toward 12).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add library entries mapping declared
   libraries to entity types.

## Where it lives in the admin menu

The configuration form is in the admin menu under **Configuration → System**. There
you add entries that pair a **declared library** (by its machine name) with the entity
type it should load on. See [Configuration](configuration/index.md).
