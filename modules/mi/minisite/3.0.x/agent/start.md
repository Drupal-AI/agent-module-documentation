<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Minisite (minisite) — agent index

Uploads a **ZIP/TAR archive of a static site**, extracts it, and serves it from a path on the Drupal
site as a **field value on an entity** (so it has an owner, revisions and workflow). Depends on core
`file`. Version **3.0.3**. Core requirement `^10.3 || ^11`.

**`manage minisites` is `restrict access: true`, and that permission is the whole security model.
Understand it before granting it:**
- extracted files are served **from the site's own origin**, and the allowed extensions include
  `html`, `js` and `svg` **because a minisite is made of them**;
- so archive content executes **as the site**: it can read non-`HttpOnly` cookies, make
  **authenticated same-origin requests as whoever is browsing**, and present a convincing login
  form on the real domain.

**Treat the permission as equivalent to deploying front-end code, not as an editorial one.**

**Two mitigations to decide deliberately:**
- a **Content-Security-Policy** on minisite paths — the only thing that meaningfully constrains the
  uploaded code;
- serving minisites from a **separate origin**, which removes the same-origin problem entirely.

**Note on the extension guard.** Archive contents are governed by the field's **allow list**
(default `ALLOWED_EXTENSIONS`) — right architecture. The **field settings form** additionally
refuses certain extensions into that list, but that guard is a **deny list** covering only
`exe scr bmp php doc rtf`: **`phtml`, `php5`, `php7`, `phar`, `pht`, `shtml` and `cgi` all pass**
(verified). `phtml` is the one that matters, being mapped to PHP in many default server configs.
`MINISITE_DENIED_EXTENSIONS` can extend the list from the environment.
