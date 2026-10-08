<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TARDIS (tardis) — agent index

**A Views style plugin rendering a reverse-chronological list of year/month links to content.**

- **Version:** 4.0.x (dev-4.0.x) · package Views · depends on `views`
- **Core:** ^10 || ^11
- **Plugin:** `@ViewsStyle(id="tardis")`, theme `views_view_tardis`, templates in `templates/`
- **Options:** `path` (link prefix, default `tardis`), `month_date_format` (PHP date format, default `m`), `nesting` (month links inside year)
- No routes, permissions, services or config.

**Security:** display-only Views style over content the view already exposes; introduces no endpoints. Nothing anonymous or mutating.

See [configure/style.md](configure/style.md)
