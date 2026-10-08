<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Random Noise (randomnoise) — agent index
**Attaches `randomnoise.us/js/squawk.js` to every page so visitors emit noise requests to random IPs.**

- **Version:** 2.0.x (2.0.1)
- **Core:** ^8 || ^9 || ^10 || ^11
- **Implementation:** single `hook_page_attachments()` adding the `randomnoise` library on all pages.
- **Library:** external minified JS `https://randomnoise.us/js/squawk.js`.
- **Routes / permissions / config:** none.

**Security:** No server-side attack surface. Observation: unconditionally loads a remote third-party script on every page for every user with no Subresource Integrity (randomnoise.libraries.yml) — a supply-chain / privacy dependency on the external randomnoise.us domain. By design.
