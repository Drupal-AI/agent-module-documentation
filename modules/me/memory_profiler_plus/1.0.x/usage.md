<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Memory Profiler Plus records request profiling memory usage in the database, for performance debugging.

---

Memory Profiler Plus records per-request memory-usage profiling data in the database — capturing how
much memory each request uses so developers can identify memory-heavy pages/operations. It is a
performance-debugging tool tagged as a developer tool.

Use it during development/profiling to find memory hotspots. It is a developer/debugging tool that writes
profiling data; because it records profiling on every request (into the database), it adds overhead and
grows data — so use it on development/staging or briefly in production for a specific investigation, not
permanently on a live site, and clean up the recorded data afterward. It has no content-access role.
Configure/enable profiling as needed.

---

- Record per-request memory usage.
- Profile memory in the database.
- Find memory-heavy pages.
- Debug performance.
- Identify memory hotspots.
- Use during development/profiling.
- Add per-request overhead.
- Not run permanently on production.
- Clean up recorded data.
- Have no content-access role.
- Capture memory profiling.
- Investigate memory use.
- Record profiling data.
- Use on dev/staging.
- Enable briefly for investigations.
- Profile requests.
- Debug memory.
- Record usage.
- Find hotspots.
- Profile memory usage.
