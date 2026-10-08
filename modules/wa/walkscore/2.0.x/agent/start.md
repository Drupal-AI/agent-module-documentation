<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WalkScore (walkscore) — agent index
**Fetches Walk Score walkability ratings from the Walk Score API for geolocation fields and displays them.**

- **Version:** 2.0.x
- **Core:** ^9 || ^10
- **Depends:** geolocation
- **Configure:** `/admin/config/services/walkscore` (`WalkScoreForm`, perm `administer walkscore`).
- **Service:** `walkscore.service` (`WalkScore`, `@http_client`) — queries `https://api.walkscore.com/score`.
- **Field plugins:** WalkScoreItem (field type), WalkScoreWidget, WalkScoreFormatter.

**Outbound:** GET to a fixed HTTPS host (endpoint not user-controllable); Guzzle default TLS settings. API key saved in `walkscore.settings`. Config route permission-gated.

See [configure/setup.md](configure/setup.md).
