<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Google Analytics (multidomain_google_analytics) — agent index

Gives each domain of a **Domain**-module multi-site its own Google Analytics / GA4 measurement id.
An admin enters one id per domain on a single settings form; a **kernel response subscriber**
(`multidomain_google_analytics.response_subscriber`) then, on every main request, resolves the active
domain via `@domain.negotiator`, reads that domain's id from the `multidomain_google_analytics.settings`
config object (config keys are the **domain entity ids**), builds the standard `gtag.js` snippet with
`getTag()`, and injects it immediately after the opening `<body>` tag by `preg_replace`ing the final
response HTML. There is no block, no field, and no per-node UI — the whole module is one config form
plus one response subscriber.

- **Project vs module name mismatch:** the drupal.org project is `domain_google_analytics` but the
  shipped module machine name is **`multidomain_google_analytics`** — enable it with
  `drush en multidomain_google_analytics` (`drush en domain_google_analytics` fails).
- Depends on: `domain:domain` (info.yml). **Also implicitly needs the `google_analytics` (Google
  Analytics) contrib module**, because the settings route is gated by that module's
  `administer google analytics` permission, which this module does not define itself.
- Core: `^9 || ^10 || ^11`. Package: `Domain`. Version 3.0.2.
- Has a settings page / `configure` route: **`multidomain_google_analytics.google_admin_settings_form`**
  (`/admin/config/system/multidomain-google-analytics`). No own permissions, no drush, no plugin
  types, no config schema.

## What you'd do → where

- **Set / change the GA measurement id for a domain (route, permission, form, config keys)** →
  [configure/settings.md](configure/settings.md)
- **Understand how/where the tracking snippet is emitted into the page** →
  [events/response-subscriber.md](events/response-subscriber.md)

## Key facts (real machine names)

- Route: `multidomain_google_analytics.google_admin_settings_form`
  (`/admin/config/system/multidomain-google-analytics`), `_form`
  `Drupal\multidomain_google_analytics\Form\MultidomainGoogleAnalyticsAdminSettingsForm`,
  `_permission: 'administer google analytics'` (defined by the `google_analytics` module, not here).
- Menu link: `multidomain_google_analytics.google_admin_settings_form` (parent
  `system.admin_config_system`) — `multidomain_google_analytics.links.menu.yml`.
- Service: `multidomain_google_analytics.response_subscriber` →
  `Drupal\multidomain_google_analytics\EventSubscriber\GoogleAnalyticResponseSubscriber`,
  arguments `@config.factory`, `@domain.negotiator`, tag `event_subscriber`. Subscribes
  `KernelEvents::RESPONSE` → method `addTag`, priority `-500`.
- Config object: `multidomain_google_analytics.settings`. **Keys are domain entity ids**
  (`$domain->id()`); each value is that domain's raw GA id string. No config schema ships.
- Form id: `multidomain_google_analytics_admin_settings`
  (`getEditableConfigNames()` → `multidomain_google_analytics.settings`). One `textfield` per domain,
  `#maxlength`/`#size` 64, title `Google Analytics ID for Domain: @hostname`.
- Hook: `multidomain_google_analytics_help()` (help.page + the settings route).
- No `*.permissions.yml`, no `composer.json`, no `config/` directory, no submodules, no libraries.
