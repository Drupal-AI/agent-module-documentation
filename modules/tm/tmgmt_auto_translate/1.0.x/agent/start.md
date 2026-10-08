<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Translation Management Auto Translate — agent index

**Automatically translates content on publish / at a moderation state** (via TMGMT — no manual submission).
Depends on `tmgmt`, core `node`. Version **1.0.0-beta1**. Core `^9||^10||^11`.

Multilingual — sends content to the configured TMGMT translator (external MT = data-handling; auto-trigger
removes the human "should this be sent?" gate — scope triggers deliberately; review auto-translations). No
access role.
