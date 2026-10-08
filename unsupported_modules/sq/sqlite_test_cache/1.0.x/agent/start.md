<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sqlite Test Cache (sqlite_test_cache) — agent index
**A kernel-test base class that caches SQLite test-database setup to speed up test runs.**

- **Version:** 1.0.x
- **Core:** ^8 || ^9 || ^10 · **Package:** Testing
- **Surface:** none at runtime — only `tests/src/Kernel/SqliteCachedKernelTestBase.php`
- No routes, permissions, services, or config.

**Security:** No request surface, no routes, no config — a developer/CI test helper only; nothing to expose.
