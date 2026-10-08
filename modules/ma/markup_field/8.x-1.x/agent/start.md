<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Markup Field — agent index

Field type that **stores rendered markup output + its dependent assets (CSS/JS)** (store/re-display
pre-rendered content). Version **8.x-1.3-beta1**. Core `^8||^9||^10||^11`.

**Security:** stores **markup that is output** — untrusted/unsanitized HTML/JS in the field is a **stored-XSS
vector** on display. Restrict who can set it to trusted users, sanitize the markup, control what generates
it. No access role.
