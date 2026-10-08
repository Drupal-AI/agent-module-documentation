<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled Preview Iframe (decoupled_preview_iframe) — agent index

Embeds a decoupled/headless front end inside an `<iframe>` on the Drupal entity view so editors
see the front-end rendering of the content they are working on. `hook_entity_view_alter()` replaces
the render array with the `preview_iframe` theme hook for bundles you enable; the iframe `src` is
`preview_url` + the page's own path-alias (+ an optional draft `?token=`). A separate, opt-in
anonymous-redirect event subscriber can bounce anonymous visitors off the Drupal domain to the
front end. No module dependencies, no permissions of its own (the settings form uses core
`administer site configuration`), no Drush; config schema ships.

- **Configure the preview URL, enabled bundles, route-sync and draft provider** → [configure/settings.md](configure/settings.md)
- **Override the iframe markup / understand the theme hook, library and JS** → [theme/preview-iframe.md](theme/preview-iframe.md)

Key facts:
- Config object: `decoupled_preview_iframe.settings` (schema in `config/schema`). Keys:
  `redirect_anonymous` (bool), `redirect_url` (uri), `preview_url` (uri),
  `preview_types` (sequence keyed by entity type → bundle→bundle), `route_sync` (string),
  `draft_provider` (string). Defaults leave `preview_url` empty and `preview_types: []`, so the
  module does nothing until configured.
- Settings route/form: `decoupled_preview_iframe.settings` →
  `/admin/config/decoupled_preview_iframe/settings`, form
  `Drupal\decoupled_preview_iframe\Form\SettingsForm` (form id `decoupled_preview_iframe_settings`),
  permission `administer site configuration`; `configure:` points here.
- Preview is enabled per entity type + bundle. The form exposes `node` and `taxonomy_term` bundles
  (`media` is listed in `supportedEntityTypes()` but skipped in the option builder).
- Iframe fires only in `default`/`full` view mode for an enabled bundle; sets `#cache max-age = 0`.
- `hook_form_node_preview_form_select_alter()` hides core's `view_mode` select on
  `entity.node.preview` for enabled bundles.
- Theme hook `preview_iframe` (variables `url`, `showPublishedToggle`) → `templates/preview-iframe.html.twig`.
- Library `decoupled_preview_iframe/site` (`js/decoupled_preview_iframe.site.js`,
  `css/decoupled_preview_iframe.site.css`, deps `core/drupal`, `core/drupalSettings`).
- Service `decoupled_preview_iframe.event_subscriber`
  (`EventSubscriber\RedirectAnonymousSubscriber`, `KernelEvents::REQUEST` priority 30).
- `route_sync` is the `postMessage` `type` the JS listens for (default
  `DECOUPLED_PREVIEW_IFRAME_ROUTE_SYNC`; use `NEXT_DRUPAL_ROUTE_SYNC` with the Next.js module).
- `draft_provider`: `none` or `graphql_compose_preview` (only offered when that module is enabled).
- Update hook `decoupled_preview_iframe_update_10001` migrates legacy `node_types` →
  `preview_types['node']`, `route_sync.type` → `route_sync`, `draft.provider` → `draft_provider`.

```bash
drush cset decoupled_preview_iframe.settings preview_url 'https://front.example.com' -y
drush cset decoupled_preview_iframe.settings preview_types.node.article article -y
drush cset decoupled_preview_iframe.settings route_sync 'DECOUPLED_PREVIEW_IFRAME_ROUTE_SYNC' -y
drush cset decoupled_preview_iframe.settings draft_provider none -y
drush cr
```

Operational note: the iframe loads a third-party origin — the front end must permit being framed
from the Drupal domain (framing-permissive response headers) or the preview renders blank. This
module supplies the URL only; draft/unpublished rendering depends on `draft_provider` and the front
end honouring the forwarded token.
