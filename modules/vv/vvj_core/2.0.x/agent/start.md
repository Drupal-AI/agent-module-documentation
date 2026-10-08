<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VVJ Core (vvj_core) — agent index

Shared foundation for the **VVJ** family of accessible, framework-free Views display formats
(`vvja` accordion, `vvjb` carousel, `vvjt` tabs). Version **2.0.0**.
Core **`^11.3 || ^12`**, **PHP 8.3**. Depends on `views`, `filter`.
No routes, permissions or config.

**Installed automatically with any VVJ module** — not chosen directly.

Two reasons to know it exists: the family shares one implementation of keyboard/ARIA behaviour, so
accessibility fixes land once; and when debugging a VVJ format, the behaviour is usually here
while the markup is in the format module.