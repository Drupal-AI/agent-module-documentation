# Configure Redirect 404 to Home Page

Settings form: `admin/config/search/redirect404_home` (route `redirect404_home.settings`, menu link
under *Configuration › Search and metadata*), gated by core permission `administer site
configuration`. Form class `Redirect404HomeConfigurationForm` (a `ConfigFormBase`).

## Config object `redirect404_home.settings`

| Key | Type | Default | Form widget | Meaning |
|---|---|---|---|---|
| `redirection` | int | `301` | select `301`/`302`/`303`/`307` | HTTP status of the redirect `on404()` returns. |
| `status_message` | string | `''` | textfield (trimmed on save) | Optional Messenger message shown after redirect; empty = no message. |
| `status_message_color` | string | `status` | select `error`/`status`/`warning` | Messenger message type passed to `MessengerInterface::addMessage()`. |

Config schema: `config/schema/redirect404_home.schema.yml` (`config_object`). Defaults ship in
`config/install/redirect404_home.settings.yml`.

## How it hooks in

- `src/Routing/RouteSubscriber.php` — `alterRoutes()` finds route `system.404` and overwrites its
  `defaults` so `_controller` becomes `\Drupal\redirect404_home\Controller\Redirect404Home::on404`.
  (It replaces the whole `defaults` array, so the route's original `_controller` default is dropped.)
- `src/Controller/Redirect404Home.php` — `on404()` builds
  `new RedirectResponse(Url::fromRoute('system.404')->toString(), $redirection)` and, if
  `status_message` is non-empty, calls `messenger->addMessage($status_message, $status_message_color)`.

## Enabling it (per README)

1. Leave the site's *Default 404 (not found) page* empty:
   `drush cset system.site page.404 '' -y` (so core routing falls through to `system.404`).
2. `drush cr`. Any 404 now goes through `on404()`.

Set the config with Drush instead of the UI:

```bash
drush cset redirect404_home.settings redirection 302 -y
drush cset redirect404_home.settings status_message 'That page has moved.' -y
drush cset redirect404_home.settings status_message_color warning -y
```

## Redirect-target caveat (important, verified on Drupal 11)

`on404()` redirects to `Url::fromRoute('system.404')`, which resolves to the path `/system/404` — the
very route whose controller this module overrode. So a request for a missing page returns
`301 → /system/404`, and `/system/404` again returns `301 → /system/404`: an **infinite redirect
loop**, not a redirect to the front page the name/README imply. Reproduced with
`curl -sI <site>/does-not-exist` → `Location: /system/404`, and `/system/404` → same. Before relying
on this module, confirm the behavior on your version; a working "send 404s to the front page" outcome
would require the controller to target `<front>` rather than `system.404`.
