<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Internal Network Condition provides block visibility and Twig conditions based on internal IP ranges.

---

Internal Network Condition **shows/hides content based on whether the visitor's IP is in configured internal
ranges** — a condition plugin (for block visibility) and Twig helpers that test the client IP against admin-defined
CIDR ranges (global and per-taxonomy-term), e.g. to show internal-only blocks to office/VPN IPs. It depends on core
Block, in the Access Control package.

Use it to vary content by internal vs external network. Understand precisely what it is: a **visibility
condition**, not a hard access-control boundary. Two caveats matter. (1) It is **block/Twig visibility** — hiding a
block does not truly protect its data (the underlying content/route may still be reachable by other means), so
don't use it as the sole protection for sensitive content; enforce real access with permissions/entity access. (2)
It keys on the **client IP** (`$request->getClientIp()`), whose accuracy depends on Drupal's reverse-proxy trust
settings — if `X-Forwarded-For` is trusted incorrectly, a client could spoof an internal IP and satisfy the
condition. Configure the CIDR ranges and, if used behind a proxy, correct `reverse_proxy` settings. It has this
conditional role only. Configure the internal ranges.

---

- Test the client IP against internal CIDR ranges.
- Provide a block-visibility condition + Twig helpers.
- Show internal-only content to office/VPN IPs.
- Depend on core Block.
- Serve conditional display.
- Support global + per-term ranges.
- BE a visibility CONDITION, not a hard access boundary.
- Not truly protect data by hiding a block (enforce real access separately).
- Key on the client IP (accuracy depends on reverse-proxy trust — spoofable if XFF mis-trusted).
- Configure the CIDR ranges + correct reverse_proxy settings behind a proxy.
- Have this conditional role only.
- Configure the internal ranges.
- Handle IP-based visibility.
- Gate visibility by IP.
- Configure the ranges.
- Show internal content.
- Handle the condition.
- Match CIDR ranges.
- Not be the sole protection.
- Provide an internal-network condition.
