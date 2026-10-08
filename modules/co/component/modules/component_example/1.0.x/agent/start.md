<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Component Example (component_example) — agent index

Submodule of **component**. **Sample components** demonstrating the single-YAML-file format.
Version **1.0.0-rc5**. Core `^9 || ^10 || ^11`.

The fastest way to check what the parent's claim actually looks like — settings schema, library
attachment, what the component receives — none of which a description conveys.

**The parent cannot currently be enabled** (`ComponentDiscovery` tagged
`plugin_manager_cache_clear` without implementing `clearCachedDefinitions()`; fatals on every cache
clear, and mid-install because installation ends with one). So neither can this. Both documented
from source.

Reading it is still worthwhile — the YAML format is legible on its own, and this is where to start
if the parent's one-line defect is fixed.