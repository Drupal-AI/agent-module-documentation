<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IP Condition — agent index

A **condition plugin evaluating the visitor's IP address** (block/component visibility). Version **1.0.3**. Core
`^9||^10||^11`.

**Visibility, NOT access control** — the **client IP is spoofable** (`X-Forwarded-For`; needs trusted-proxy
config); never protect sensitive content by IP. No access role.
