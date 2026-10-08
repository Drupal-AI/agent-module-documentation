<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JapaneseEraFormatter (japanese_era_formatter) — agent index

**Field formatter rendering datetime values in the Japanese imperial era (wareki) calendar.**

- **Version:** 1.0.x
- **Core:** `^10`. **Package:** Date. **Dep:** core `datetime`.
- **Provides:** FieldFormatter `datetime_japanese_era` (`JapaneseEraDateFormatter`, extends `DateTimeFormatterBase`) for `datetime` fields; `Enum\Era` defines era start dates.
- **Config:** via field display settings (date_format + output format string); config schema included.

**Security:** No routes, permissions, services, SQL or external calls — a pure display formatter. No security-relevant surface.