<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Memory Profiler Plus — agent index

Records **per-request memory-usage profiling in the database** (find memory-heavy pages/operations).
Developer tool. Version **1.0.0**. Core `^9.4||^10||^11`.

Developer/debugging — writes profiling per request (overhead + data growth); use on dev/staging or briefly
in production for a specific investigation (clean up after), not permanently. No content-access role.
