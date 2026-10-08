<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Batch Messenger groups Symfony Messenger messages into named collections, shows their progress in a Batch-style admin UI, and can transparently convert core `batch_set()` operations into Messenger messages that run off-thread in workers.

---

Batch Messenger is a developer/infrastructure module with three parts. Its base API lets you tag any dispatched Messenger message as one item of a **collection** by attaching a `CollectionItem` stamp (shared collection ID + unique per-message identifier); an entry middleware records the item as pending and a post-handle middleware marks it processed, giving you live pending/processed counts per collection. The optional **UI** (enabled by default) exposes those collections at *Reports → Message sets* (`/admin/reports/batch-messenger`) with a per-collection progress bar and adds a toolbar progress indicator; a "Clear complete" action prunes finished sets. The optional **Batch API bridge** (enabled by default) implements `hook_batch_alter()` to replace a legacy batch's queue with an internal one that dispatches each operation as a `LegacyBatchItem` Messenger message, simulating `$context` (sandbox, results, finished callback, messages) so existing batch code runs largely unchanged — but off-thread and in parallel via Messenger workers, with the classic Batch progress screen retained. It requires the `sm` (Symfony Messenger) module and, to run operations out of band, an asynchronous Messenger transport plus a running `messenger:consume` worker; with a sync transport, operations run inline. It is a drop-in replacement for Batch API and can be uninstalled to restore stock behavior (in-progress batches are lost). Most classes are marked `@internal`.

---

- Adopt Symfony Messenger for long jobs while keeping a Drupal-style progress UI for end users.
- Tag related Messenger messages into a collection so their combined progress can be tracked.
- Dispatch N messages with a shared collection name and unique identifiers, then watch pending → processed counts.
- Show site admins a live list of message sets and how far each has progressed at `/admin/reports/batch-messenger`.
- Surface a toolbar progress bar so users see an in-progress batch without keeping the batch screen open.
- Convert an existing `batch_set()`-based bulk operation to run in Messenger workers with no code rewrite.
- Move heavy batch operations off the web thread so PHP-FPM/web workers don't need to scale for them.
- Run batch operations in parallel across multiple Messenger workers instead of single-threaded.
- Let a batch continue processing even after the user navigates away from the batch progress page.
- Allow a user to return to the Message sets page later to check on a batch that is still running.
- Increase CPU/memory limits for heavy work in the worker while keeping web threads lean.
- Preserve legacy batch semantics (`$context['sandbox']`, `$context['results']`, finished callback) under Messenger.
- Capture messages an operation sends to `\Drupal::messenger()` and route them to the Batch Messenger log channel.
- Store per-operation results and hand them to the batch's finished callback when all operations complete.
- Gate visibility of all message sets behind the `batch_messenger ui view all batches` permission.
- Provide a CSRF-protected "Clear complete" admin action to delete fully processed collections.
- Tune the artificial per-operation delay via the `batch_messenger.operation_sleep` service parameter.
- Disable the UI or the Batch bridge independently by overriding the `batch_messenger.ui` / `batch_messenger.batch_bridge` parameters.
- Migrate a module incrementally from Batch API toward native Messenger usage.
- Retry a failed operation via Messenger's `failed` transport (a single failure blocks the set's completion).
- Use collection tracking standalone (base functionality) without the Batch bridge for your own Messenger workflows.
- Evaluate whether a job is finished by reading a collection's pending count (complete when pending is zero).
