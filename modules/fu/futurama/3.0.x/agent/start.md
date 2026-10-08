<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Futurama (futurama) — agent index

**A block that shows a random caption/title quote from the TV show Futurama.**

- **Version:** 3.0.x (3.0.1)
- **Core:** ^9 || ^10 || ^11
- **Block:** `futurama_block` (`FuturamaBlock`) — `build()` returns a random `#markup` caption from `futurama_title_captions()` (~110 hard-coded strings, wrapped in `t()`, some with small inline HTML).
- **No routes, permissions, services or config.**
- Note: a `futurama_generate/` folder contains Form/Controller classes but has no `.info.yml`/routing — not an installable submodule here.

**Security:** Single block plugin with no user input, no routes and no mutating endpoints. Output is a fixed developer-authored caption list rendered as markup. No security-relevant surface.