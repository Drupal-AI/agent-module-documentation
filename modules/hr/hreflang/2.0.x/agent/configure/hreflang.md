# Configure hreflang tags

## Settings form

Route `hreflang.admin_settings` at `/admin/config/search/hreflang`
("Admin → Configuration → Search and metadata → Hreflang tags"), gated by the
`administer site configuration` permission. Form class
`Drupal\hreflang\Form\ModuleConfigurationForm` (form id `hreflang_admin_settings`), a
`ConfigFormBase` using `#[ConfigTarget]`-style `#config_target` bindings. It edits the
`hreflang.settings` config object (schema in `config/schema/hreflang.schema.yml`, so it
exports/deploys with `drush config:export`). Edit keys directly with
`drush cset hreflang.settings <key> <value>`.

## Settings — `hreflang.settings`

| Key | Default | Meaning |
|---|---|---|
| `x_default` | `true` | Add an extra `hreflang="x-default"` tag pointing at the default language |
| `x_default_fallback` | `true` | Point the x-default tag at the configured fallback (selected) language instead of the site default, when one is set |
| `defer_to_content_translation` | `false` | On content-entity pages, let Content Translation add the per-language tags; Hreflang then adds only the x-default tag (if enabled) |

(Install defaults from `config/install/hreflang.settings.yml`.)

## How tags are generated

`Drupal\hreflang\Hook\PageAttachments::__invoke()` (the `page_attachments` hook):

- Returns early (no tags) on 403/404 pages (request has an `exception` attribute), and when
  the site is **not multilingual**.
- Builds URLs from the route match (or `<front>` on the front page), then uses the core
  language manager's `getLanguageSwitchLinks(LanguageInterface::TYPE_INTERFACE, $url)` to emit
  one `rel="alternate" hreflang="{langcode}"` link per language, as absolute URLs.
- Adds the `url.query_args` cache context so query strings are preserved on the tags.
- If `x_default` is on, also emits `hreflang="x-default"` for the default language
  (or the fallback language when `x_default_fallback` is on and
  `language.negotiation` `selected_langcode` is set and not the site-default sentinel).

## Defer to Content Translation

When `defer_to_content_translation` is true and Content Translation is enabled, Hreflang
skips its own per-language tags on content-entity pages (routes with an `entity:*` parameter
whose entity has a canonical link template and an id) and defers to
`content_translation_page_attachments()`. Hreflang still adds the x-default tag (respecting
the untranslated source entity's `view` access, whose access result is added to the page's
cacheable metadata). Trade-off: Content Translation does not add query args to its tags, so
pages with query args won't have a complete tag set — but caching is more efficient (no
separate cache per query-arg set).

## Cache clearing

`Drupal\hreflang\EventSubscriber\HreflangConfigSubscriber` (service
`hreflang.config_subscriber`) listens on config save; when any of the three keys change it
invalidates the `http_response` cache tag (via `CacheTagsInvalidatorInterface`) and shows a
status message, so new settings take effect immediately.

## Drupal 7 migration

A `hreflang_settings` migration (`migrations/hreflang_settings.yml`) maps the legacy D7
`hreflang_x_default` variable into `hreflang.settings:x_default`.
