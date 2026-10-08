<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group context: Path prefix — agent index

Provides a **group context based on a URL path prefix** (resolve the active group from `/prefix/...`).
Depends on `group`. Version **1.1.4**. Core `^10.2||^11`.

Group-context provider — **resolves** the active group but relies on Group's membership/permissions for
access (doesn't grant). No access role of its own.
