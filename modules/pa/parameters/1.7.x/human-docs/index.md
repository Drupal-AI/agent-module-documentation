# Parameters — manual setup guide

**Parameters** (`parameters`) is a kind of "Config Construction Kit". Every
project eventually needs somewhere to put a value — an API endpoint, a threshold,
a feature flag, a set of business rules, a mapping table, a percentage. The usual
homes for such values are all more work than the value deserves: a full settings
form means writing a form class, a config schema, a route, a permission and a menu
entry; `settings.php` means a code deployment for every change and nothing an
administrator can edit; and a custom block or node is really content pretending to
be configuration. Parameters gives you the container directly — a named, typed,
fielded settings object you create through the UI, no form class required.

Parameters can be defined globally for the whole site, or scoped to specific
content types. Once defined, you read them from **Tokens**, **Twig**, **ECA**, or
directly through the module's API. The module also protects itself: collections in
active use are auto‑locked, and a locked collection cannot be deleted through the
UI until it is unlocked again.

Two submodules complete the picture. **Parameters UI** (`parameters_ui`) adds the
administrative interface for creating and editing parameters — you will almost
always want this. **Parameters Content** (`parameters_content`) provides a
content‑side variant of parameters for values that should behave like content
rather than configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and the submodules you need.
2. [Configuration](configuration/index.md) — where the interface lives, and the
   two decisions to settle before you store a value.

## Where it lives in the admin menu

The base module provides the storage and API but no interface of its own. Enable
the **Parameters UI** submodule and you get an admin screen for creating and
managing parameters (see [Configuration](configuration/index.md) for the walk
through). Individual parameters are then available to Tokens, Twig, and ECA
wherever you need the value.
