<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTTP Parameter Pollution — agent index

**Security hardening:** mitigates **HTTP Parameter Pollution (HPP)** — a `KernelEvents::REQUEST` subscriber
**de-duplicates query parameters, keeping the last occurrence** (predictable single value; normalizes
rather than rejects). Version **1.0.1**. Core `^9||^10||^11`.

Positive defense-in-depth control (no content-access role). "Last wins" matches PHP's default; sensible
for Drupal/PHP.
