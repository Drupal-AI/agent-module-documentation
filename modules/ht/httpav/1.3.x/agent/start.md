<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTTP Anti-virus (httpav) — agent index

Submits **file uploads to an HTTP endpoint for anti-virus scanning** (e.g. ClamAV HTTP shim / SaaS
scanner) — reject malware before storage. Version **1.3.3**. Core `^10.3||^11.0`.

**Security:** point at a trusted scanning endpoint over **TLS** (checked — module doesn't disable TLS);
decide fail-closed vs fail-open on scanner outage (**prefer fail-closed**). One layer, not a
guarantee.
