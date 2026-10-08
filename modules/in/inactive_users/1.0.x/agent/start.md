<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Inactive Users — agent index

**Detects users inactive for a period, warns them by email, and can block/delete dormant accounts**. Depends on
core `user`. Version **1.0.4**. Core `^10||^11`.

**Security-positive** account hygiene (prunes a common attack surface) — but deletion is **destructive**: set a
sensible threshold + grace period, **exempt admin/service accounts + protected roles**, choose block-vs-delete
deliberately (deletion affects authored content). Cron-driven, admin-gated.
