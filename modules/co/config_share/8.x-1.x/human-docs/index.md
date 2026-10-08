# Configuration Share — manual setup guide

**Configuration Share** (`config_share`) lets several modules, features, and
distributions *share* commonly needed configuration items — things like user roles
and field storages — instead of each shipping and owning its own copy. It exists to
solve a specific interoperability problem: today, distributions typically put shared
config in a "base" or "core" feature that every other feature depends on, which
means features from *different* distributions cannot coexist on the same site
because their base dependencies conflict.

Configuration Share breaks that deadlock. Shared configuration lives in a module's
`config/shared` directory and is **not** installed when that module is installed.
Instead it is installed only *on demand* — when another piece of configuration that
depends on it is being installed. So a curated set of common items (a body field
storage, for example) can be provided once and pulled in only where it is actually
needed, letting features from multiple sources safely declare a dependency on the
same shared repository without conflicts.

This is squarely a developer and distribution-builder tool. It changes *how*
configuration is provided and shared; it has no runtime behaviour, no admin screen,
and no access-control role. The intended standard repository for shared config is
the companion **Compatible** module, but you can create your own custom shared
repository as an interim step. Note the module depends on the **Configuration
Provider** module (2.x or 3.x branch), and it is minimally maintained (this is the
8.x‑1.0‑rc5 release), so treat it as infrastructure for people building
interoperable distributions rather than a general site-building convenience.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

The module has **no settings form and no admin page** — you use it entirely from
your modules' file structure, so there is no configuration page.

## How to use it

To provide shared configuration from your own module:

1. Add `config_share` to your module's `dependencies` in its `*.info.yml` file.
2. Place the configuration items you want to make shareable in the module's
   `config/shared` directory (rather than `config/install`). They will not be
   installed with the module — only when another config item depends on them.
3. If a shared configuration item has its *own* module dependencies (for example a
   field storage that needs the Geolocation module), do **not** add those to the
   sharing module — that would recreate the very dependency conflicts this module
   exists to avoid. The dependency only matters when the shared item is actually
   installed.

For most teams, the recommended path is to contribute common items to the
**Compatible** module and depend on that, using a custom shared repository only
while candidate additions are pending.
