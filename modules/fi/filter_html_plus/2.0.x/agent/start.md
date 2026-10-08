<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Filter HTML Plus — agent index

Extends core's **"Limit allowed HTML" filter to allow global whitelisting of attributes** (`<*>` syntax —
allow `class`/`data-*` on all elements). Depends on core `filter`. Version **2.0.1**. Core `^9||^10||^11`.

Text-format/filter — works **within core's filter_html sanitization**; security depends on what you whitelist:
**never** globally allow `on*` event handlers or `style` (widens XSS surface). No access role.
