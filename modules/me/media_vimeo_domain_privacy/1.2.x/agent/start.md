<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Vimeo Domain Privacy (media_vimeo_domain_privacy) — agent index

Makes core's media system work with Vimeo videos set to **domain-level privacy**. Depends on core
`media`. Version **1.2.0**. Core requirement `^8.8 || ^9 || ^10 || ^11`. GPL-2.0-or-later.

## The problem it fixes

Core's Remote video media source uses **oEmbed**. To add a Vimeo video, Drupal's server fetches its
metadata (title, thumbnail, embed HTML) from Vimeo's oEmbed endpoint. When a Vimeo video is set to
**domain-level privacy** (playable only on a whitelisted domain), Vimeo's oEmbed endpoint refuses to
return the full metadata unless the request carries a `Referer` header matching that whitelisted
domain. A plain server-side fetch has no such header, so **creating the media entity fails**.

## The entire mechanism (there is nothing else)

The module ships exactly one thing: an **`http_client_middleware`** service.

- `media_vimeo_domain_privacy.services.yml` registers the service
  `media_vimeo_domain_privacy.vimeo_domain_privacy_middleware`, tagged `http_client_middleware`, so
  Guzzle wraps it around **every** request made through Drupal's `http_client`.
- `src/HttpClientMiddleware/VimeoDomainPrivacyMiddleware.php` (`__invoke`) inspects each outgoing
  request. If the request URI host matches the regex `/\.?vimeo\.com$/`, it sets the request's
  `Referer` header to `\Drupal::request()->getSchemeAndHttpHost() . '/'` — i.e. the current site's
  own scheme+host — and passes the request on.

So the "whitelisted domain" sent as the referrer is **the Drupal site's own host**, taken from the
incoming request. There is **no config form, no route, no permission, no schema, no template, no
hook, no Drush command**. When enabled it just works, provided the site's host equals the domain
whitelisted in Vimeo's video privacy settings.

## Requirements & limits

- The site's public host **must equal** the domain whitelisted on the Vimeo video. There is no
  setting to override the referrer, so **decoupled/headless setups** (front-end domain ≠ Drupal
  host) are **not supported** — a known limitation with an open `@todo` in the code.
- Uses `getSchemeAndHttpHost()`, which derives from the incoming Host header; configure
  `trusted_host_patterns` in `settings.php` as usual.

## Two things about the mechanism rather than the module

1. **Domain privacy is a deterrent, not an access control.** It is enforced by a **request header a
   determined person can set**, and the video URL still exists. It keeps a video off other people's
   sites; it does not keep it from someone who wants it. Vimeo's stronger options are **password
   protection** and **unlisted-with-hash** links — if the material is genuinely confidential, a
   domain allow-list is not the answer.
2. **An embedded player is still a third-party request** with cookies and a view reported to Vimeo.
   The consent question applies exactly as for a public video.

## Troubleshooting

If the video does not appear: confirm the Vimeo video's domain-privacy allow-list contains the exact
domain the Drupal site serves from, and that the module is enabled. Because the referrer is the live
site host, adding the video on a non-whitelisted environment (e.g. a staging domain) will fail even
though production works.
