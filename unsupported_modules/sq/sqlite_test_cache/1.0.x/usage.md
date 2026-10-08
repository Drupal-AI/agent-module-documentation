<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sqlite Test Cache provides a kernel-test base class (`SqliteCachedKernelTestBase`) that caches the SQLite test database setup so repeated test runs skip re-running the expensive install/schema setup.
---
The module contains no runtime code, routes, permissions, services or config — it ships only `tests/src/Kernel/SqliteCachedKernelTestBase.php`, an abstract base for developers to extend in their own kernel tests. Tests that extend it reuse a cached SQLite fixture between runs instead of rebuilding the schema and default content each time, which meaningfully reduces the per-test setup cost when using the SQLite database driver.

Because it has no request surface, there is no operational or security posture to configure — it is a developer/CI aid only. Setup is simply requiring the module in a project's dev/test environment and having kernel test classes extend the provided base instead of `KernelTestBase`.
---
- Enable the module in a dev/test environment only.
- Extend `SqliteCachedKernelTestBase` in your kernel tests.
- Cache the SQLite test database setup between test runs.
- Speed up local kernel-test iteration.
- Reduce redundant schema installs across a test suite.
- Reuse a prepared SQLite fixture instead of rebuilding it.
- Use it as a drop-in base for SQLite-backed kernel tests.
- Keep it out of production module lists.
- Pair it with the SQLite database driver for tests.
- Shorten CI kernel-test wall-clock time.
- Avoid re-seeding default content on every test.
- Standardise a cached test base across a codebase.
- Inspect the base class to see what setup it memoises.
- Add it to `require-dev` in composer for a project.
- Benchmark test setup time with and without the cache.
- Use it to prototype expensive schema setups once.
- Share the cached fixture across related test cases.
- Debug flaky setups by disabling the cache path.
