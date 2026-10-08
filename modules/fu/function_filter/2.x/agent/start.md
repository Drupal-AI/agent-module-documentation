<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Function Filter — agent index

**Text filter running registered functions via `[function:*]`**. Version **2.x-dev**. Core `^8..^11`.

Positive: only `hook_filter_functions`-registered functions run (allowlist, name sanitised) — NOT arbitrary exec. Enable on trusted formats.