<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contact Author — agent index

A **block linking to a node author's personal contact form**. Depends on core `contact`. Version **1.0.1**.
Core `>=8`.

User-engagement, **safe** (reviewed): recipient derived **server-side from the node owner** (not a request
param); author **email never exposed**; sending delegated to core's contact form (permission + hourly flood
control) — no open-relay/spam path. No access role of its own.
