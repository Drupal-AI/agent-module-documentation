<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Varbase Core is the foundation module of the Varbase distribution: it enables and pre-configures the module set a Varbase site is expected to have, ships shared configuration, roles and role-permission grants, and provides eight packaged submodules that each own one area of that setup.

---

Varbase Core is a *composition*, not a feature. Its `composer.json` requires ~100 contrib projects (ECA + BPMN.iO for automation, Gin/Gin Login for admin, Webform, Content Lock, Password Policy, SecKit, Security Review, CAPTCHA/reCAPTCHA, Honeypot, Antibot, Better Exposed Filters, Field Group, Display Suite, Views Bootstrap, Entityqueue, Inline Entity Form, Trash, Project Browser, Automatic Updates and more). `hook_install` then enables the ~60 modules listed under `install:` in its info.yml and bulk-imports its `config/optional/` config by regex scan; `hook_modules_installed` defers more "managed" config for automated_cron, editoria11y, sitewide_alert and varbase_email until those modules are turned on. Its own code is small: a settings landing page at `/admin/config/varbase`, a two-checkbox general-settings form (`varbase_core.general_settings` — `welcome_status`, `allow_custom_account_name`), five developer drush commands, node/subqueue form alters, two provided tokens (`[site:origin-url]`, `[default-active-theme:path]`), and a single `access varbase settings` permission. Role permissions for anonymous/authenticated/editor/content_admin/seo_admin/site_admin ship under `config/permissions/`. The eight submodules split the rest: varbase_admin (admin config), varbase_page (Basic page type), varbase_security (password policy, SecKit, honeypot, username-enumeration prevention), varbase_internationalization, varbase_webform, varbase_tour, varbase_default_content and varbase_development — whose own description warns it must be disabled in production. Core is pinned to `~11.4.0`, so the module tracks one Drupal minor rather than a range.

---

- Stand up a Varbase site with its expected module set already enabled and configured.
- Adopt Varbase's opinionated Drupal baseline instead of assembling one by hand.
- Enable ECA-based automation (login, role-change and recertification workflows) out of the box.
- Ship an opinionated security baseline (password policy, SecKit, Security Review, honeypot).
- Get the Gin admin theme and admin tooling pre-configured.
- Add a Basic `page` content type with Varbase's field, layout and SEO setup.
- Group all distribution settings under one `/admin/config/varbase` landing page.
- Toggle the front-page welcome message (`?welcome`) on or off.
- Allow or disallow custom account usernames site-wide.
- Manage which configuration is ignored on deployment (config_ignore is a hard dependency).
- Auto-apply managed defaults when you later enable automated_cron, editoria11y, sitewide_alert or varbase_email.
- Provide the `[site:origin-url]` and `[default-active-theme:path]` tokens to other modules.
- Enable multilingual support as a single submodule switch.
- Provide guided editor tours / a welcome modal to new authors.
- Load starter default content for a fresh site.
- Turn on developer tooling (devel, dblog, reroute_email) only in non-production environments.
- Gate the distribution settings pages behind one permission.
- Reorder the node-edit sidebar to Varbase's expected layout.
- Repair mismatched entity/field definitions after upgrades via `drush edupdb`.
- Strip permissions that no longer exist after an upgrade via `drush rnep`.
- Run optional per-module update hooks on demand via `drush varbase-up`.
- Localize merge-request patches into the project's `patches/` folder via `drush var-ccup`.
- Layer additional Varbase feature modules on a shared, common core.
- Give a team a consistent baseline across many Varbase sites.
- Pin a site deliberately to a single Drupal core minor.
