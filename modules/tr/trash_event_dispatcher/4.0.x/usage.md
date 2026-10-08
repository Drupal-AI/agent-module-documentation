<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Trash Event Dispatcher exposes Trash-module hooks as Hook Event Dispatcher events.

---

Trash Event Dispatcher dispatches events for the Trash module (soft-delete / recycle bin) via the Hook Event Dispatcher — so developers can subscribe to Trash operations (trash, restore, purge) as OOP events instead of implementing procedural hooks, fitting event-driven codebases.

It's a developer/integration module with no content or access role of its own. Depends on `hook_event_dispatcher` (^4.0) and `trash`; supports Drupal 9.3+, 10, and 11.

---

- Dispatch events for Trash operations.
- Expose Trash hooks as events.
- Support trash/restore/purge events.
- Enable OOP event subscribers.
- Fit event-driven codebases.
- Build on Hook Event Dispatcher.
- Depend on `hook_event_dispatcher` (^4.0).
- Depend on `trash`.
- Support Drupal 9.3+, 10, and 11.
- Carry no content/access role.
- Aid developers.
- Integrate Trash.
- Subscribe to soft-delete events
- Handle Trash events
- Support event-driven code.
- Provide events.
- Dispatch hooks.
- Integrate the recycle bin
