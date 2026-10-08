<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theme By Author (theme_by_author) — agent index
**Applies the page author's chosen theme via a per-user theme base field and a theme negotiator.**

- **Version:** 2.0.x — core `^9 || ^10`
- **Depends on:** options, user
- **Field:** `theme` base field on user entities (`list_string`, allowed values = installed themes)
- **Service:** `theme.negotiator.theme_by_author` (theme_negotiator, priority 100)
- **Security:** no module routes or permissions; only surface is the per-user Theme field on the user form under normal user-edit access; no external calls or mutating endpoints.
