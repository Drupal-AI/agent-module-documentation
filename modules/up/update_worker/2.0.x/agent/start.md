<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Update Worker — agent index

Cron **queue worker that runs developer-provided callbacks** (`callback` + `arguments` per queue item;
`call_user_func_array`, callbacks in `*.update_worker.php`) — defers arbitrary work to cron. Version
**2.0.2**. Core `^8||^9||^10||^11`.

**Sharp edge:** whatever fills the queue chooses what code runs on cron. Ships **no user-facing
callback endpoint** (not end-user exploitable as shipped) — but the invariant is **only trusted code
may write to this queue**; never derive callbacks from untrusted input. Treat like hook_cron/batch.
