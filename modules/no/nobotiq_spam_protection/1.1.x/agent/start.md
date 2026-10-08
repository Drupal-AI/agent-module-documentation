<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# NoBotIQ Spam Protection — agent index

**Spam protection via the nobotiq.com API** (checks submissions, VBO support). Stores credentials via **`key`**.
Depends on core `views`, `views_bulk_operations`. Provides permissions. Version **1.1.1**. Core `^10.3||^11||^12`.

Spam-control/integration — **sends submission data to NoBotIQ** (egress — content/IP; disclose); **API key via the
Key module** (positive); decide fail-open vs closed, HTTPS. No access role beyond permission.
