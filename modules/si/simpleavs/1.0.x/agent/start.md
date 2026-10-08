<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple AVS (Age Verification) — agent index

A **cookie/session-based age-verification gate** (themable "over N?" overlay). Provides permissions. Version
**1.0.5**. Core `^10.2||^11`.

**Advisory age prompt:** a JS overlay (`hook_page_attachments`) over the normally rendered page; the
Yes/No answer and the date of birth are self-reported by the visitor; one-time session token
(`random_bytes`). Use access control when content must be restricted.
