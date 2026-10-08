<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AddThis Social Share adds AddThis share buttons, targeting tools and content recommendations to a Drupal site.

---

Install the module (depends on field and block), then visit /admin/config/user-interface/addthis (permission: administer addthis settings) and the advanced form at /addthis/advanced (permission: administer advanced addthis settings). Place the AddThis block via the Block layout UI. The AddThisScriptManager service builds the third-party AddThis script include.

---

- Add social share buttons to pages.
- Render buttons through a Drupal block plugin.
- Configure which services appear via the settings form.
- Use a separate advanced settings form for extra options.
- Gate basic config behind 'administer addthis settings'.
- Gate advanced config behind 'administer advanced addthis settings'.
- Depend on core field and block modules.
- Load the AddThis third-party script via AddThisScriptManager.
- Support per-language script configuration.
- Increase likes, shares and follows.
- Place the block per region in Block layout.
- Note: AddThis service was discontinued by the vendor in 2023.
- Serve as a front-end social widget only.
- Have no access-control role.
- Keep buttons on public content pages.
- Configure through the two admin routes.
- Target content recommendations.
- Add sharing to any theme region.
