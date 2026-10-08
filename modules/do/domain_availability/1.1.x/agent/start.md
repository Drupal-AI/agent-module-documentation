<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Availability — agent index

**Parallel RDAP/WHOIS domain-availability** sweep (reports unknown, never guesses). Version **1.1.2**. Core `^10.3||^11`.

Defensive: permission-gated routes, `DomainSanitizer`, per-IP rate limiting (security positive). Depends on core `file`/`options`/`user`, `saudi_id_validator`.