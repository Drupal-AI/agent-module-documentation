<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Beta Site extends Drupal with beta-testing plumbing: a parallel "beta" path-alias namespace and UI helpers to switch a visitor between the standard and beta version of a page.

Use it to expose beta variants of content/paths to testers alongside the live site.

---

Install with `composer require drupal/betasite` and enable `betasite` (`drush en betasite`). Optional submodules add features: `betasite_toggle_block` (a toggle block + AJAX link), `betasite_switches`, `betasite_layout_builder`, `betasite_menu_breadcrumb`, and `betasite_menu_trail_by_path`.

Admin lives under `/admin/config/development/betasite` (`access administration pages`). The toggle submodule exposes `/beta-link` (access: TRUE) which, given `domain` and `path`, returns the corresponding beta or standard alias as JSON.

---

- Provide a beta path-alias namespace alongside standard aliases.
- Offer a block to toggle between standard and beta views of a page.
- Expose a `/beta-link` AJAX endpoint returning the alternate alias as JSON.
- Look up standard aliases via a parameterized `path_alias` query.
- Ship a `betasite_toggle_block` submodule for the toggle UI.
- Ship a `betasite_switches` submodule with its own routes/permissions.
- Ship a `betasite_layout_builder` submodule.
- Ship `betasite_menu_breadcrumb` and `betasite_menu_trail_by_path` submodules.
- Provide an admin section at `/admin/config/development/betasite`.
- Use a route subscriber to register dynamic routes.
- Store beta aliases through a dedicated alias-storage service.
- Let testers switch between live and beta content.
- Support Drupal 9 and Drupal 10.
- Gate admin pages behind `access administration pages`.
- Keep the beta toggle endpoint anonymous-reachable for front-end use.
- Return the original path when no beta alias exists.
- Modularize features across optional submodules.