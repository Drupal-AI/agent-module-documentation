<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Update Worker provides a cron queue worker that executes callbacks (with arguments) supplied as queue items, for deferring arbitrary work to cron.

---

Update Worker provides a single cron queue worker that executes callbacks placed on its queue: each
queue item carries a `callback` and `arguments`, and on cron the worker loads `*.update_worker.php`
include files (the recommended home for callback definitions) and runs the callback via
`call_user_func_array()`. It is a developer utility for deferring arbitrary work — bulk updates, data
migrations, batch maintenance — to background cron processing without writing a full QueueWorker plugin
each time.

**Understand the sharp edge before use.** Because it calls arbitrary callbacks taken from queue-item
data, whatever populates the queue effectively chooses what code runs on cron. The module ships **no
HTTP or user-facing endpoint that accepts callbacks** — the queue is meant to be filled by trusted
server-side code (your own module/deploy scripts) — so it is not exploitable by end users as shipped.
But the invariant to maintain is exactly that: **only trusted code may write to this queue**, and
callback definitions must live in your `*.update_worker.php` files, never derived from untrusted input.
Treat it like a hook_cron/batch mechanism, not a user-facing feature. It has no permissions or config
of its own.

---

- Defer arbitrary work to cron.
- Run callbacks from queue items.
- Execute developer-provided callbacks.
- Place callback+arguments on a queue.
- Load callbacks from *.update_worker.php.
- Run bulk updates in the background.
- Avoid writing a QueueWorker each time.
- Process data migrations on cron.
- Only let trusted code fill the queue.
- Never derive callbacks from user input.
- Keep callback defs in include files.
- Treat it like hook_cron/batch.
- Understand it runs call_user_func_array.
- Have no user-facing callback endpoint.
- Not be end-user exploitable as shipped.
- Run batch maintenance via cron.
- Defer heavy work off the request.
- Have no permissions or config.
- Queue background tasks.
- Guard what writes to the queue.
