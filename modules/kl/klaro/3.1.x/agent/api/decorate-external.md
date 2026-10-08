# Gate scripts, libraries & embeds until consent

Klaro holds external assets back until the matching `klaro_app` service is consented. It
does this three ways — no custom code needed for the first two.

## Drupal libraries / script tags
`klaro.module` implements `hook_js_alter()`, `hook_library_info_alter()` and
`hook_page_attachments_alter()`. Script/library tags that belong to a configured service are
rewritten (type/`data-name` attributes) so Klaro loads them only after consent. Attach the
Klaro widget itself is handled by `hook_page_attachments()`. So: map a service to the
library/script id in its `klaro_app` config and Klaro does the blocking.

## Body-content embeds — the text filter
Plugin `klaro_filter` (`@Filter` id `klaro_filter`, "Klaro! Filter: Decorate external
sources"). Enable it on a text format (`/admin/config/content/formats`). It decorates
`<iframe>`/embed markup in field content so external sources (YouTube, maps, etc.) show a
click-to-load placeholder and only load after the visitor accepts the relevant service.
Combine with a service's `contextual_consent_only` / `contextual_consent_text` for per-embed
prompts.

## Helper service
`klaro.helper` (`Drupal\klaro\Utility\KlaroHelper`) centralizes the logic — resolving which
services/purposes apply, building attachment data, matching cookie patterns. Inject it
(`@klaro.helper`) if you need to query consent configuration programmatically. A
`ResponseSubscriber` event subscriber finalizes the response-level integration.
