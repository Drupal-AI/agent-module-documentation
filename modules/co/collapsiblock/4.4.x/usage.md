<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Collapsiblock makes individual Drupal blocks collapsible: click a block's title to slide its body open or closed. Each block picks a collapse behavior (or inherits a site-wide default), and for some behaviors each visitor's open/closed choice is remembered in a cookie.

---

Sidebars, footers and menu regions accumulate blocks, and on small screens a tall stack of them pushes the real content down. Collapsiblock lets a visitor fold away the blocks they are not using and lets a site builder ship some blocks collapsed by default, without writing per-block theme or JavaScript. It works entirely at the block level: a "Collapsible" setting on each block's configuration form (and on Layout Builder add/update-block forms) chooses from a small set of behaviors — not collapsible, collapsible starting expanded, collapsible starting collapsed, always collapsed, always expanded — or defers to a global default set at Configuration » User interface » Collapsiblock. The animation speed, cookie lifetime, whether menu blocks on the active page may still collapse, and an optional dark-mode arrow color switcher are all global settings. State is kept in a single `collapsiblock` cookie whose lifetime is configurable (including a "never store a cookie" option for privacy). Being a front-end enhancement, its one real compatibility concern is the theme: the collapse behavior attaches around the block title via the template's `title_prefix`/`title_suffix`, and content marked `collapsiblock-force-open` (or a menu block on the current page) can be kept open. It relies on the `js_cookie` module and a bundled slide-animation library, so there is no jQuery requirement.

---

- Make a specific block collapsible by clicking its title.
- Ship a sidebar block collapsed by default.
- Let visitors fold away blocks they are not using.
- Set a site-wide default collapse behavior for all blocks.
- Override the global default on one block.
- Keep a block always collapsed with no memory of the toggle.
- Keep a block always expanded but still toggleable.
- Remember each visitor's open/closed choice across pages.
- Configure how long the state cookie lives (in days).
- Use a session-only cookie by leaving the lifetime blank.
- Disable the state cookie entirely for GDPR compliance (negative lifetime).
- Tune the open/close slide animation speed.
- Tidy a long sidebar on mobile layouts.
- Collapse a footer block on page load.
- Give blocks simple accordion-style behavior.
- Set collapse behavior on a Layout Builder block.
- Keep a menu block expanded when it links to the current page.
- Allow menu blocks with active links to collapse anyway.
- Force a block (e.g. an AJAX form) to stay open via `collapsiblock-force-open`.
- Recolor the collapse arrow for a dark theme via the color switcher.
- Reduce clutter in content-dense regions.
- Apply per-block collapsing without custom code.
- Configure collapse behavior with Drush or exported config.
