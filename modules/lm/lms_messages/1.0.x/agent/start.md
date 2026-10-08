<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LMS Messages — agent index

**Notifies users of LMS events by creating Message entities** (via Message / Message Notify). Depends on `lms`,
`message`, `message_notify`, `token`. Version **1.0.0-alpha5**. Core `^10||^11`.

Integration/notifications (reviewed CLEAN) — only **creates** messages addressed to a recipient uid (settings
form gated by `administer lms`); reading is delegated to Message/Message Notify access. No access role of its
own.
