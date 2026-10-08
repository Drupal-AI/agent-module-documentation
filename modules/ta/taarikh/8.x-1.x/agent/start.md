<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Taarikh (taarikh) — agent index

**Hijri (Islamic) calendar field widgets, formatters and form elements built on core datetime, with a pluggable conversion-algorithm system.**

- **Version:** 8.x-1.x
- **Core:** ^10.2 || ^11
- **Dependencies:** datetime
- **Widget:** `TaarikhDefaultWidget`; **Formatter:** `TaarikhDefaultFormatter`
- **Elements:** `TaarikhDate`, `TaarikhDatetime` (`src/Element/`)
- **Plugin type:** `TaarikhAlgorithm` (annotation + `AlgorithmPluginManager`, service `plugin.manager.taarikh_algorithm`); default plugin `FatimidAstronomical`
- **Routes/permissions:** none.

**Security:** No routes, permissions, controllers or network calls — a pure field/UI layer over core datetime. No request-facing attack surface.

See [plugins/algorithms.md](plugins/algorithms.md)
