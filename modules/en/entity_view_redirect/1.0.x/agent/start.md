<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity View Redirect (entity_view_redirect) — agent index

Redirects the **canonical view page** of core **node**, **taxonomy term**, and **user** entities to
their **edit form** (default) or an admin-configured **internal path**. Package `Search and metadata`.
No module dependencies (node/taxonomy/user are core). Core `^9 || ^10 || ^11`. License GPL-2.0-or-later.
Version 1.0.0.

- **How the redirect fires, the config it reads, per-bundle setup, the bypass permission** →
  [config/settings.md](config/settings.md)

## What it actually is

- One event subscriber: `Drupal\entity_view_redirect\EventSubscriber\EventSubscriber` (service
  `entity_view_redirect.event_subscriber`, in `src/EventSubscriber/EventSubscriber.php`), subscribed
  to `KernelEvents::REQUEST` via `redirectToEditPage()`. No controller, route, plugin, or Drush.
- Form alters in `entity_view_redirect.module` add settings to the **node type**, **taxonomy
  vocabulary**, and **user account settings** forms. No standalone config route (`configure` is null).
- One config object `entity_view_redirect.settings` (user redirect only; schema in
  `config/schema/entity_view_redirect.schema.yml`). Node/vocabulary settings are stored as
  **third-party settings** on the respective bundle config entity, not in this object.
- One permission: **`bypass entity view redirect`** (`entity_view_redirect.permissions.yml`).

## Mechanism (from source)

- `redirectToEditPage(RequestEvent $event)` returns early if the current user has
  `bypass entity view redirect`. Otherwise it matches the route name:
  `entity.node.canonical`, `entity.taxonomy_term.canonical`, or `entity.user.canonical`.
- For nodes/terms it reads the bundle's third-party settings (`node_view_redirect` /
  `node_redirect_path`; `vocabulary_view_redirect` / `vocabulary_redirect_path`). For users it reads
  `entity_view_redirect.settings` (`user_view_redirect` / `user_redirect_path`).
- When the redirect flag is on and a custom path is set, `%` in the path is replaced with the
  entity ID and the target is built with `Url::fromUri('internal:' . $custom_path)->setAbsolute()`.
  With no custom path it builds the entity's `*.edit_form` route URL. It then calls
  `$event->setResponse(new RedirectResponse($url))`.
- Subscribed at **default priority** on `KernelEvents::REQUEST`, so it runs *after* core routing and
  entity access resolution — the canonical route's own view-access check still applies before the
  redirect. The redirect target is admin-configured, not taken from the request.

## Config keys

- `entity_view_redirect.settings`: `user_view_redirect` (boolean), `user_redirect_path` (text).
- Node type third-party settings: `node_view_redirect` (bool), `node_redirect_path` (path or FALSE).
- Vocabulary third-party settings: `vocabulary_view_redirect` (bool), `vocabulary_redirect_path`.
- Details, form locations, and an example in [config/settings.md](config/settings.md).
