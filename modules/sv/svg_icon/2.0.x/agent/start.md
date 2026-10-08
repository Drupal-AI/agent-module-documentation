<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SVG Icon — agent index

Field type for **uploading SVG icons and sprites**. Depends on core `file`; provides permissions. Version
**2.0.0-beta2**. Core `^9.3||^10||^11`.

**SECURITY — SVG upload = XSS risk:** SVGs can embed JavaScript (`<script>`, event handlers,
`<foreignObject>`) → if user-uploaded SVGs are served **inline** from origin, a malicious SVG runs script
(stored XSS). Restrict upload to trusted roles; **sanitize SVGs** (strip scripts) or serve non-executing
(`<img src>`/restrictive CSP); never inline untrusted SVGs.
