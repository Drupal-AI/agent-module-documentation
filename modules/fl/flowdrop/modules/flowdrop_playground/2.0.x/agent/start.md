<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FlowDrop Playground (flowdrop_playground) — agent index

Submodule of **flowdrop**. Chat-based surface for **running a workflow by hand** and watching it.
Version **2.0.0**. Core `^11.3`.

Removes the awkward loop of testing an event-triggered workflow (produce the event → find the run
→ read the jobs). Pairs with `flowdrop_job` / `flowdrop_pipeline` for per-node detail.

**Development tool.** It runs arbitrary workflows on demand — a capability worth restricting on a
production site.