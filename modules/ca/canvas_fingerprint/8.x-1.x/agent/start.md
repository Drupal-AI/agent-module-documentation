<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# canvas_fingerprint — agent orientation

- Client-side canvas-fingerprinting JS + a single demo page `/fingerprint` (`fingerprint.demo`, `access content`).
- Only server code is `src/Controller/PageDemo.php::page` returning a render array with attached libraries — NO endpoint receives or stores the fingerprint.
- Security review: no server-side PII collection, no external calls, no DB writes. Privacy-sensitive technique but module itself is a benign demo.
- No config form/settings; package "Stat".
