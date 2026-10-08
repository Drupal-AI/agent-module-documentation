<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hello Contrib (hello_contrib) — agent index
**Minimal example module: one admin page that prints a greeting.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Route:** `hello_contrib.admin` → `/admin/hello-contrib`
- **Permission:** core `access administration pages`
- Controller returns a translated `#markup` string. No config/services/custom permissions.

**Security:** single admin page gated by core `access administration pages`; static translated markup, no user input, no mutating or anonymous endpoints.
