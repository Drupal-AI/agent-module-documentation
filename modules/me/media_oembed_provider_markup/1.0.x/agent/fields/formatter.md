<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# oEmbed provider-markup formatter override

How `media_oembed_provider_markup` extends core Media's `oembed` field formatter to output the
provider's own embed HTML instead of Drupal's proxied `/media/oembed` iframe. Everything lives in
`media_oembed_provider_markup.module` (procedural; no classes).

## Install / enable
`drush en media_oembed_provider_markup`. Core **Media** must be enabled (it supplies the `oembed`
formatter and the two oEmbed services below). Enabling changes nothing until you switch on the
per-display setting — the module is dormant otherwise.

## The third-party setting
Two hooks attach a checkbox to the **core** `oembed` formatter (they no-op for any other
formatter):

- `hook_field_formatter_third_party_settings_form($plugin, …)` — when
  `$plugin->getPluginId() == 'oembed'`, adds element `provider_markup` (`#type => checkbox`,
  title *"Use provider's markup for oEmbed field"*), defaulted from
  `$plugin->getThirdPartySetting('media_oembed_provider_markup', 'provider_markup')`.
- `hook_field_formatter_settings_summary_alter(&$summary, $context)` — appends a summary line
  *"Use provider's markup for oEmbed field. Other options may be ignored."* when the setting is on.

Stored in the entity view display as
`third_party_settings.media_oembed_provider_markup.provider_markup`. Schema (in
`config/schema/media_oembed_provider_markup.schema.yml`):
`field.formatter.third_party.media_oembed_provider_markup` → mapping with one key
`provider_markup` (type `integer`, label "Use Provider Markup"). `provides_config_schema: true`.

**Where to toggle:** Manage display for the media type (e.g. Remote video), on the field using the
`oembed` formatter → gear icon → check "Use provider's markup for oEmbed field". Gated by the
standard core display-admin permission (e.g. `administer media display`) — there is no permission
of this module's own.

## The render override
`hook_preprocess_field(&$variables)` runs only when `$variables['element']['#formatter'] == 'oembed'`.
It reloads the effective display via `EntityViewDisplay::collectRenderDisplay($entity, $view_mode)`,
reads `getComponent($field_name)`, and returns early unless
`third_party_settings.media_oembed_provider_markup.provider_markup` is set.

For each field item it:
1. Reads the core-rendered iframe `src` from `$item['content']['#attributes']['src']` (the
   `/media/oembed?url=…&max_width=…&max_height=…&hash=…` proxy URL) plus the `width`/`height`
   attributes.
2. `parse_str(parse_url($url, PHP_URL_QUERY), $query)` → extracts `$query['url']` as the original
   provider media URL, and takes `width`/`height` as `max_width`/`max_height`.
3. Re-resolves and re-fetches the resource through core Media's services:
   - `\Drupal::service('media.oembed.url_resolver')->getResourceUrl($media_url, $max_width, $max_height)`
   - `\Drupal::service('media.oembed.resource_fetcher')->fetchResource($resource_url)`
   - `$html = $resource->getHtml();`
4. Fires `\Drupal::moduleHandler()->alter('media_oembed_provider_markup', $html)` so other modules
   can rewrite the HTML string (implement `hook_media_oembed_provider_markup_alter(&$html)`).
5. Replaces the item's render array with `['#markup' => Markup::create($html), '#cache' => $cache]`,
   preserving the original `#cache` metadata from `$item['content']['#cache']`.

Net effect: instead of `<iframe src="…/media/oembed?url=…">` the field prints the provider's own
markup, e.g. `<iframe src="https://www.youtube.com/embed/<id>?feature=oembed" …>`.

## Alter hook
```php
function mymodule_media_oembed_provider_markup_alter(&$html) {
  // $html is the provider's raw embed markup string; mutate in place.
}
```
Use it to add attributes, wrap the embed in a consent facade, etc.

## Operating notes
- Per-display: enable it only on the view modes/fields that need provider markup; other displays
  keep core's proxied iframe.
- Purpose: the provider domain reappears in the markup so a Consent Management Platform can detect
  and gate the embed (core's `/media/oembed` URL hides it).
- Test coverage: `tests/src/Functional/OEmbedTest.php` asserts the default output contains the
  `/media/oembed?url=…` proxy and, after enabling `provider_markup: 1` on the display, contains
  `src="https://www.youtube.com/embed/<id>?feature=oembed"`.
- No update hooks, no Drush commands, no libraries, no default config install.
