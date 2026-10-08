<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Workbench Email (workbench_email) — agent index

Sends **templated emails on content-moderation transitions**. Version **2.x** (dev on this site).
Core `^10.5 || ^11 || ^12`. Depends on core `content_moderation`, `filter`.
Permission: `administer workbench_email templates`. Templates are tokenised filtered text.

Attach a template per transition (→ Needs Review pings reviewers, → Published/→ Draft notifies the
author). Configure recipients (roles/author/users) precisely — over-broad = inbox noise, missing =
silent workflow. What makes a moderation workflow actually move.