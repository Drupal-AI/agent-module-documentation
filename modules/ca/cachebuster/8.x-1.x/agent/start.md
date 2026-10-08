<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cache Buster (`cachebuster`) — agent index
**Dev aid: rewrites CSS as external (no aggregation) so browsers always reload stylesheets.**

- **Version:** 8.x-1.x  | **Core:** ^8 || ^9 || ^10
- No routes, no permissions, no config UI.
- Logic: `cachebuster_css_alter()` sets each non-external CSS `type=external`, prefixes `/`, and adds an admin warning to uninstall in production.

**Security:** no user input, no routes; a development-only asset alter. No findings. (Operational note: disables CSS aggregation — not for production.)
