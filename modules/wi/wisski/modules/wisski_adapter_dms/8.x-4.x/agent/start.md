<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WissKI DMS Adapter (wisski_adapter_dms) — agent index

Submodule of **wisski**. Queries the **Germanisches Nationalmuseum's DMS** directly.
Version **8.x-4.3**. Core `>=10.4 <12`.

**Institution-specific** — GNM was a WissKI founding partner and this reads their particular
documentation system. For anyone else it is a **worked example** of an adapter against a bespoke
institutional catalogue, which is the situation many museums are in.

**If it is enabled on a site that is not GNM's, investigate** — most likely enabled during
evaluation and never removed, which adds an unmonitored external dependency.