# Library Select — manual setup guide

**Library Select** (`library_select`) lets editors choose which registered asset
libraries (CSS/JS) to attach on a **per‑node or per‑entity** basis. You add a
field to a content type, and when an editor fills in a piece of content they can
pick from a list of predefined libraries — so a specific page can load an extra
slider, widget, or stylesheet without any theme changes.

The important detail is that editors select from the site's **registered**
libraries — the ones defined by modules and themes — not from arbitrary URLs or
raw code they type in. That keeps the set of things that can be attached bounded
to what the site already ships. The module also integrates with the **CodeMirror
Editor** for a nicer editing experience, and it ships a **`library_select_context`**
submodule that plugs into the Context module so you can attach a library to any
page via context rules rather than per node.

> **A note on trust:** attaching a library means loading its JavaScript and CSS on
> the page, so restrict the module's permission to **trusted editors**. A careless
> or malicious selection could load an unexpected library. The module has no
> access‑control role beyond its own permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   optionally add the Context submodule.
2. [Configuration](configuration/index.md) — defining the selectable libraries,
   choosing which entities can select, and the permission that gates it.

## Where it lives in the admin menu

Library Select is configured at **Configuration → Development → Library Select**
(`/admin/config/development/library_select_entity`), where you define the
libraries editors may choose and which entities can select them.

## How to use it

1. Define the selectable libraries and enable selection on the entities you want
   (see [Configuration](configuration/index.md)).
2. Grant the Library Select permission to your trusted editor roles.
3. When editing a node (or other enabled entity), an editor picks the libraries to
   attach for that item.
4. Those libraries load only on that content. For page‑level rules instead of
   per‑node choices, enable the `library_select_context` submodule and attach
   libraries through Context. You can also attach a Library Select library to a
   Views display using the **Views Attach Library** module with the format
   `library_select/{machine_name}`.
