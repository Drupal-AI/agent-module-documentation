<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FlowDrop Session (flowdrop_session) — agent index

Submodule of **flowdrop**. **Session and message entities** plus services, for interactive
workflow execution. Version **2.0.0**. Core `^11.3`.

Entities rather than scratch state, and the consequences are the point: conversations survive
reloads and restarts, are listable/searchable/reportable, follow **entity access**, and can be
**deleted** — a conversation with a user is personal data.

Underpins `flowdrop_chat` and `flowdrop_playground`. Pairs with `flowdrop_memory`: the session is
the **transcript**, memory is what the agent **retains** from it.