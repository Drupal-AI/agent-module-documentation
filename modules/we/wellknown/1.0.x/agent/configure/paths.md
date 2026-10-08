<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure .well-known paths

The whole module is one settings form plus a dynamic route provider. You define a
list of name/value pairs; each becomes a live `/.well-known/<name>` URL that returns
`<value>` as its body.

## Settings form

- Route: `wellknown.settings_form` — path `/admin/config/development/well-known`
  (menu link `wellknown.admin_settings` under *Configuration › Development*).
- Access: core permission `administer site configuration` (the module defines no
  permission of its own).
- Form class: `Drupal\wellknown\Form\WellKnownSettingsForm` (extends `ConfigFormBase`,
  form id `wellknown_settings_form`).
- UI: an AJAX table (`#type => table`) with an *Add new path* button and a *Remove*
  button per row. Each row has a **Name** textfield and a **Value** textarea. Empty
  rows are dropped on save (`filterPaths()` — a row needs both `name` and `value`).
- On save (`submitForm`) it writes `wellknown.settings:paths` and then calls
  `\Drupal::service('router.builder')->rebuild()` so the new/removed dynamic routes
  register immediately.

## Config object

Config name: `wellknown.settings`. Editable name returned by
`getEditableConfigNames()`. Shape:

| Key              | Type     | Meaning                                             |
|------------------|----------|-----------------------------------------------------|
| `paths`          | sequence | List of path definitions.                           |
| `paths.N.name`   | string   | Path segment after `/.well-known/` (e.g. `security.txt`). |
| `paths.N.value`  | string   | Raw response body served at that URL.               |

Default (shipped): `paths: [ ]` (empty — the module serves nothing until you add a path).

## Set via PHP

```php
\Drupal::configFactory()->getEditable('wellknown.settings')
  ->set('paths', [
    [
      'name'  => 'security.txt',
      'value' => "Contact: mailto:security@example.com\nExpires: 2027-01-01T00:00:00Z\n",
    ],
    [
      'name'  => 'change-password',
      'value' => 'https://example.com/user/password',
    ],
  ])
  ->save();

// Required so the dynamic routes appear without waiting for a full cache clear.
\Drupal::service('router.builder')->rebuild();
```

## Set / inspect via drush

```bash
# Inspect current definitions.
drush cget wellknown.settings

# Add one path (sequence indices are 0-based).
drush cset wellknown.settings paths.0.name security.txt -y
drush cset wellknown.settings paths.0.value "Contact: mailto:security@example.com" -y

# Rebuild routes so /.well-known/security.txt goes live.
drush cr
```

## What happens at runtime

1. `Drupal\wellknown\Routing\WellKnownRouteSubscriber::alterRoutes()` (an
   `event_subscriber`, service `wellknown.route_subscriber`) reads
   `wellknown.settings:paths` on every route rebuild.
2. For each entry it adds a `Symfony\Component\Routing\Route`:
   - path `/.well-known/<name>`, route name `wellknown.<name>`;
   - defaults `_controller` → `WellKnownController::response`, and `content` → the
     stored `value`;
   - requirement `_access: 'TRUE'` (the endpoint is anonymous/public — the expected
     behavior for RFC 8615 `/.well-known/` URIs).
3. `Drupal\wellknown\Controller\WellKnownController::response($content)` returns
   `new Response($content)`. The body is exactly the stored `value`. No `Content-Type`
   is set, so Symfony defaults to `text/html; charset=UTF-8`; if you need JSON (e.g.
   `apple-app-site-association`, `assetlinks.json`) be aware the response is served as
   HTML unless you sit a reverse proxy / rewrite in front of it.

## Directory-layout gotcha

This module ships its schema at `schema/wellknown.schema.yml` and its default config at
`install/wellknown.settings.yml` — **not** the core-standard `config/schema/` and
`config/install/`. Core only discovers config schema from `config/schema/` and default
install config from `config/install/`, so neither file is loaded: `wellknown.settings`
has no registered typed-config schema at runtime, and the `paths: [ ]` default is not
written on install (the form falls back to `[]` when the key is absent, so it still
works). Practical effect: `drush config:inspect` / config validation report the object
as schema-incomplete, and there is no type coercion on the stored values.
