<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Redirect" field formatter

No configure route (`configure: null`) and no admin settings page. You attach the formatter to
a field on an entity bundle's **Manage display** page. State is stored in the
`entity_view_display` config entity.

## Plugin

- id: `field_redirection_formatter`, label **"Redirect"**
- field_types: `link`, `entity_reference`, `file`
- class: `Drupal\field_redirection\Plugin\Field\FieldFormatter\FieldRedirectionFormatter`

## Settings

```yaml
# core.entity_view_display.<entity>.<bundle>.<view_mode>
content:
  field_target:
    type: field_redirection_formatter
    label: hidden
    settings:
      code: 301               # 300 | 301 (default) | 302 | 303 | 304 | 305 | 307
      404_if_empty: false     # throw a 404 when the field is empty
      page_restrictions: 0    # 0 = all pages | 1 = only listed | 2 = all except listed
      pages: ''               # newline-separated Drupal paths; supports *, <front>, tokens
```

- `code` — HTTP status for the redirect. Options in the UI: 300 Multiple Choices, 301 Moved
  Permanently (default), 302 Found, 303 See Other, 304 Not Modified, 305 Use Proxy, 307
  Temporary Redirect.
- `404_if_empty` — when the field has no value, return the 404 page instead of doing nothing.
- `page_restrictions` — scope the redirect: `0` everywhere; `1` only on the paths in `pages`;
  `2` everywhere except those paths.
- `pages` — one Drupal path per line. `*` is a wildcard (`blog/*`), `<front>` is the front
  page, and tokens work (e.g. `node/[node:nid]`).

Config schema: `field.formatter.settings.field_redirection_formatter` defines these four keys.

## Important: view mode

The redirect fires whenever the entity is rendered with this formatter. The maintainers warn
it should only be used on the **Full content** view mode — on any other view mode the settings
form shows a warning ("should not be used with any view mode other than Full content"),
because e.g. a teaser in a listing would trigger the redirect.

## Behavior / guards (from `FieldRedirectionResultBuilder`)

- **No-op under CLI** — `viewElements()` returns early when `php_sapi_name() == 'cli'`, so
  Drush rendering never redirects.
- **Redirect-loop protection** — it will not redirect when the destination equals the current
  path (relative or absolute), and not to `<front>` while already on the front page.
- **Cron / maintenance** — skips when the current path starts with `cron`, is
  `admin/reports/status/run-cron`, or the site is in maintenance mode.
- **Destination resolution** (`getUrl()`): a `link` item → its URL; a `file` item → the file
  URL; an `entity_reference` item → the referenced entity's canonical URL.
- **`bypass redirection` permission** short-circuits the redirect — see
  [../permissions/bypass-redirection.md](../permissions/bypass-redirection.md).

## Via drush php:eval (scriptable)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_target', [
  'type' => 'field_redirection_formatter',
  'label' => 'hidden',
  'settings' => ['code' => 301, '404_if_empty' => FALSE, 'page_restrictions' => 0, 'pages' => ''],
])->save();
```

## Read it back

```bash
drush cget core.entity_view_display.node.article.default content.field_target
# look for  type: field_redirection_formatter  and  settings.code
```

## Service

`field_redirection.result_builder` (`FieldRedirectionResultBuilder`, args `@path.matcher`,
`@token`, `@state`) builds a `FieldRedirectionResult` value object deciding whether/where to
redirect; the formatter calls `buildResult()` and, if it should redirect, sends the response
and `exit`s.
