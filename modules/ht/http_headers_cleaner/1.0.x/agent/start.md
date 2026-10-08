<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTTP-Headers cleaner — agent index

Removes configured **HTTP response headers + meta tags** (e.g. `X-Generator`, generator meta) to
reduce **information disclosure / fingerprinting**. Response subscriber + meta cleaner; provides
permissions. Version **1.0.1**. Core `^10||^11`.

**Only removes** (doesn't add security headers). Configure to strip informational headers only —
**don't target CSP/X-Frame-Options**; pair with a security-header module (e.g. Seckit) for
protections.
