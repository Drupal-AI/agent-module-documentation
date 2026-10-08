<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Internal Network Condition — agent index

**Block-visibility / Twig condition based on whether the client IP is in configured internal CIDR ranges** (global
+ per-term). Depends on core `block`. Version **1.1.0**. Core `^10.3||^11||^12`.

A **visibility condition, not a hard access boundary**: hiding a block doesn't protect its data (enforce real
access separately); keys on the client IP (spoofable if `X-Forwarded-For` is mis-trusted — configure `reverse_proxy`
correctly). Don't rely on it alone for sensitive content.
