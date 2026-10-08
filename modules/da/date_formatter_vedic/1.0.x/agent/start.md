<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vedic Date Formatter (date_formatter_vedic) — agent index

**Adds a custom PHP date-format character rendering the current muhūrta (48-minute Vedic time division).**

- **Version:** 1.0.x · **Core:** ^11 · **PHP:** 8.1+
- **Configure route:** `date_formatter_vedic.settings` → `/admin/config/regional/vedic-date-formatter` (permission `administer site configuration`)
- **Services:** `date_formatter_vedic.decorator` decorates core `date.formatter` (priority 10); `date_formatter_vedic.date_replacement_service` performs the muhūrta substitution.
- **Default character:** `q` (configurable); 30 muhūrta names overridable.

**Security:** single admin settings route gated by `administer site configuration`; no anonymous/mutating endpoints, no external requests. Pick a format character that does not clash with a needed standard PHP date character.

See [configure/vedic.md](configure/vedic.md)