<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Field View Lazy Load — agent index

A Views field handler that **embeds a View inside another View's rows, lazy-loaded via AJAX** (per-row
embedded Views without the up-front render cost). Depends on core `views`. Version **1.0.1**. Core
`^9||^10||^11`.

Content-display/Views — the embedded View's results respect **that View's own access**; no access role of its
own.
