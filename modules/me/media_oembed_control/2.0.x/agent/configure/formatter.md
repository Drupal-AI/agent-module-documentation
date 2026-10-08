# Configure — oEmbed formatter options & request flow

No settings page. Configuration is per field display.

## Enable the options

On a media/entity field that uses the core **oEmbed** field formatter, go to *Manage
display*, open the formatter's settings gear, and you get two checkboxes (added by
`hook_field_formatter_third_party_settings_form()`, only when the formatter plugin id is
`oembed`):

| Setting | Default | Effect |
|---|---|---|
| `video_autoplay` | FALSE | Autoplay the embed (provider permitting). |
| `video_background` | FALSE | Play as a silent, looping background video. |

Stored as third-party settings under namespace `media_oembed_control` on the
`entity_view_display` component. An element validate handler strips the settings entirely
when both are unchecked (keeps config clean). The settings summary line ("Oembed control:
…") is added via `hook_field_formatter_settings_summary_alter()`.

## How it reaches the iframe

1. `hook_preprocess_field()` runs for `oembed`-formatted fields. It parses the iframe
   `src`, resolves the provider via `media.oembed.url_resolver`, and appends a
   `media_oembed_control` query payload (`provider_name` + the chosen `settings`) to the
   iframe URL.
2. `MediaOembedControlRouteSubscriber::alterRoutes()` overrides the `_controller` of core's
   `media.oembed_iframe` route with `Drupal\media_oembed_control\Controller\OEmbedIframeController`.
3. That controller **calls `parent::render()` first** — so core's `hash` signature check on
   the `url` parameter still executes and still throws `AccessDeniedHttpException` on a bad
   hash. It then reads the `media_oembed_control` query params and, only for
   `provider_name` `YouTube` or `Vimeo`, rewrites the inner iframe `src`:
   - YouTube: always `enablejsapi=1`; autoplay → `autoplay=1&mute=1`; background →
     `background=1&controls=0&loop=1&playlist=<video id>`.
   - Vimeo: autoplay → `autoplay=1` (+`mute` semantics via provider); background → `background=1`.

## Notes

- Provider detection is by exact name match `YouTube`/`Vimeo`; other oEmbed providers are
  returned unchanged.
- There is nothing to configure globally — behaviour is entirely driven by the two
  per-display checkboxes plus core Media's own oEmbed/provider configuration.
