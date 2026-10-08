<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bitly Shortener turns long URLs into Bitly short links through a service, a Twig function, and a block.

---

Bitly Shortener integrates a Drupal site with the Bitly URL-shortening service. Its core is one
service (`bitly_shortener`) whose `shortener($url)` method POSTs the long URL to the Bitly v4
`bitlinks` endpoint using Drupal's HTTP client and returns the resulting short link. A Twig
extension exposes the same call as `{{ bitly_shortener('https://…') }}` for use in templates, and
a `Bitly Shortener` block shortens the current page's URL and renders it inside a read-only input
with a copy-to-clipboard button. An admin configures the module at
`/admin/config/bitly-shortener/api` (permission `administer site configuration`): an enable flag,
the API endpoint (default `https://api-ssl.bitly.com/v4/bitlinks`), and a Bitly access token. The
module needs no contrib dependencies and ships config schema for its settings. Note that the Twig
function and block call the external Bitly API at render time, so results should be cached and rate
limits kept in mind; the access token is a credential and should be treated as one.

---

- Shorten an arbitrary long URL from PHP with `\Drupal::service('bitly_shortener')->shortener($url)`.
- Shorten a URL inside a Twig template with `{{ bitly_shortener('https://www.drupal.org') }}`.
- Shorten the current page URL and show it with a copy button via the Bitly Shortener block.
- Place the Bitly Shortener block in any theme region through the block layout UI.
- Configure the Bitly access token, API endpoint, and enable flag at `/admin/config/bitly-shortener/api`.
- Point the module at a different Bitly-compatible bitlinks endpoint by editing the API field.
- Generate share links that resolve through your Bitly account for click analytics.
- Produce branded/custom Bitly short domains (when the Bitly account is configured for them).
- Embed a short link for the current node in a custom template using the Twig function.
- Return short links from a custom controller or form by calling the service.
- Enable or disable shortening site-wide with a single checkbox without uninstalling.
- Fall back to the original URL automatically when the module is disabled or the token is empty.
- Let editors copy the short link to the clipboard from the rendered block.
- Import the module's config (`bitly_shortener.settings`) as part of a config-managed deploy.
- Store the access token per-environment by overriding config in `settings.php`.
- Validate the token format (40 alphanumeric characters) at the settings form before saving.
- Show a live "Bitly Shortener Status" message on the settings form when shortening is enabled.
- Wrap outbound campaign URLs in a listing so each row renders a Bitly link.
- Add a shortened permalink to social-share markup rendered by a theme template.
- Alter or extend the registered Twig function set via the `bitly_shortener_functions` alter hook.
