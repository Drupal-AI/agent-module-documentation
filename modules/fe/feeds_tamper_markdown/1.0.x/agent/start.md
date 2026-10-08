<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tamper Markdown — agent index

Provides a **Feeds Tamper plugin that converts Markdown to HTML** during import. Depends on `tamper`,
`feeds_tamper`. Version **1.0.x** (dev). Core `^9||^10||^11`.

Import/transformation — Markdown can embed **raw HTML** (XSS risk), so the target field must use a **sanitizing
text format** (or trust the source). No access role.
