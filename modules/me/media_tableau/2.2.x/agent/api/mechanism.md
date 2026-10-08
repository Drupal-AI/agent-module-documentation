<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Media Tableau works internally

No public API to call — this documents the moving parts so you can reason about behavior.

## Formatter (`MediaTableauEmbedFormatter`)

- `getUrlRegexPattern()` builds a regex from `media_tableau.settings:allowed_hosts`:
  `/^(<preg_quoted hosts>)\/(.*\/)?(app\/profile\/.*\/viz\/.*|views\/.*)/`.
- `viewElements()` skips empty/non-matching items, else emits a `#theme => 'media_tableau'`
  render array with `#url` (from `formatUrl()`), `#title` (the parent media entity's name),
  `#width`/`#height`/`#toolbar` from settings, and attaches
  `media_tableau/media_tableau_embedding.<api_version>`.
- `formatUrl()` converts `.../app/profile/<name>/viz/<viz_id>` → `.../views/<viz_id>`; other
  URLs pass through unchanged.
- `deriveMediaDefaultNameFromUrl()` returns "Tableau view from <url>" when the URL matches,
  else defers to the parent (Media Remote) behavior.

## Libraries (`media_tableau.libraries.yml`)

`media_tableau_embedding.latest`, `.3.6`, `.3.5` each load the external Tableau Embedding API
JS (`type: module`) from `public.tableau.com` and depend on `media_tableau_responsive`
(the module's own responsive CSS/JS). The theme hook `media_tableau` is declared in
`media_tableau_theme()`.

## CSP event subscriber

`AllowedHostsCspEventSubscriber` (service `media_tableau.host_subscriber`, args
`@router.admin_context`, `@config.factory`) subscribes to `csp.policy_alter`. On non-admin
routes it appends the allowed hosts to the `frame-src` directive (or sets it if missing). Only
active when the `csp` module provides that event.

## Install

`media_tableau_update_9201()` seeds `allowed_hosts` with `https://public.tableau.com` if empty.
