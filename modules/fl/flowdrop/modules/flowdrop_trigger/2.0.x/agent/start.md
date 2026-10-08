<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FlowDrop Trigger (flowdrop_trigger) — agent index

Submodule of **flowdrop**. **Event-driven triggering** — run a workflow on entity create / update /
delete. Version **2.0.0**. Core `^11.3`.

The difference between a tool and automation. Replaces hooks someone would otherwise write, with
the logic editable by the process owner rather than the codebase owner.

**Two things to be deliberate about, and raise both:**

1. **Recursion** — a workflow triggered by an entity update that itself updates that entity will
   re-trigger. The guard must be explicit.
2. **Volume** — one run per change. Check the queue impact before enabling on a busy content
   type.