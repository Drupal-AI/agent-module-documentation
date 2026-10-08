<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rate Limits — permissions

One permission (`rate_limits.permissions.yml`):

| Permission | Gates |
|---|---|
| `skip rate limit checks` | Any role granted this is **exempt from all rate limits**. Checked first thing in `RequestSubscriberCheckLimits::onRequest()` via `$this->currentUser->hasPermission('skip rate limit checks')` — if TRUE the subscriber returns before any flood check. |

Notes:
- Not marked `restrict access: true`, but it only *loosens* enforcement (removes throttling for
  the holder); it grants no data or state-changing capability.
- Grant it to trusted internal/service roles that must not be throttled (e.g. cron, monitoring,
  authenticated API clients you trust).
- Managing the limit entities themselves uses the entity's `admin_permission`,
  `administer site configuration` — not this permission.
