<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Inline Entity Form Event Dispatcher dispatches events for Inline Entity Form hooks via Hook Event Dispatcher.

---

Inline Entity Form Event Dispatcher **dispatches events for Inline Entity Form hooks** — turning IEF's hooks
into Symfony events (via the Hook Event Dispatcher module) so developers can subscribe with event subscribers
instead of hook implementations. It depends on Hook Event Dispatcher and Inline Entity Form.

Use it as a developer bridge for IEF hooks. It is a developer/framework feature; it re-exposes existing hooks as
events and has no content or access role. Subscribe to the IEF events in code.

---

- Dispatch events for IEF hooks.
- Bridge IEF hooks to Symfony events.
- Enable event subscribers for IEF.
- Depend on Hook Event Dispatcher + IEF.
- Serve developers.
- Re-expose hooks as events.
- Re-expose existing hooks only.
- Have no content/access role.
- Subscribe to the IEF events.
- Handle IEF events.
- Dispatch events.
- Configure nothing (framework).
- Fire events.
- Handle the hooks.
- Subscribe to events.
- Configure developers.
- Handle the dispatch.
- Bridge hooks.
- Provide IEF event dispatching.
