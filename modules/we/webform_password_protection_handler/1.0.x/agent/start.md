<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Password Protection Handler — agent index

A webform handler that **gates a form behind a shared password**. Depends on `webform`. Version **1.0.2**. Core
`^8.8||^9||^10||^11`.

**Caveats:** the password compare is **`===` (non-constant-time** — should be `hash_equals()`), and the password
is stored **plaintext in the handler config** (config-exportable → may hit git/config sync). Treat it as a
**low-value shared secret**, not account auth or real access control on sensitive data.
