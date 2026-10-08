<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Unomi connection

## Connector plugin
Connectivity uses the `UnomiConnector` plugin type (manager `plugin.manager.unomi.connector`). The bundled `BasicAuthUnomiConnector`:
- Stores `username` / `password` config; the password field can be left blank to keep the existing saved value.
- Builds a Guzzle client with `base_uri => getServerUri()` and `auth => [username, password]` (`Plugin/UnomiConnector/BasicAuthUnomiConnector.php:98-99`).
- TLS is at Guzzle defaults; the server URI comes from config.

To support another auth strategy (e.g. token/OAuth or a hosted platform), implement a new `@UnomiConnector` annotated plugin.

## Settings form
At `/admin/config/services/unomi` (`administer unomi`) enter:
1. The Unomi server URI (self-hosted or hosted service).
2. Basic-auth username/password.

Responses are cached in the `cache.unomi` bin; errors go to `logger.channel.unomi`.

## Using segments
The `SegmentSelection` condition plugin evaluates the visitor's Unomi segments (resolved via `UnomiCookieManager` + the client) so blocks and other condition-aware plugins can personalize content by segment membership.
