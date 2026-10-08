<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
## What it does

- Adds an Ecwid (SaaS) online store to a Drupal site by embedding Ecwid's hosted storefront.
- Connects the site to an Ecwid store via an OAuth authorization flow and stores the resulting store id and access token in config.
- Provides a storefront page (`/store`), a connect page, and an admin control-panel iframe backed by Ecwid SSO.

---

## Install & configure

- Enable the module (the actual module machine name from `ecwid.info.yml` is `ecwid`; the project/directory is `ecwid_shopping_cart`).
- Start the connection at `/admin/ec-store-connect`, authorize with Ecwid; the callback `/admin/ec-store-connect/token` exchanges the OAuth code and saves the store credentials.
- Manage the store from `/admin/ec-store` (control panel iframe) and expose the storefront at `/store`.

---

## Usage & behaviour

- The connect/token/control-panel routes declare `_permission: 'access content'`.
- `Connect::getToken()` reads `$_REQUEST['code']`, performs an OAuth exchange, and writes `storeId`/`token`/`publicToken` into `ecwid.config`.
- The storefront routes (`/store`, `/store/{something}`) are also `access content` and render the store id into an Ecwid JS embed.
- The control-panel iframe URL is built with `hash('sha256', storeId . token . time . clientSecret)` for Ecwid SSO.
- OAuth token exchange uses the core Guzzle `http_client` over HTTPS with default TLS verification (no `verify=>false`).
- The stored access token grants API access to the connected Ecwid store; treat `ecwid.config` as sensitive.
- Store rendering is done via Twig templates that embed Ecwid's storefront script by store id.
- Use it for small sites that want a hosted cart without running Drupal Commerce.
- No inventory/order data is stored in Drupal; everything lives in Ecwid.
- The storefront is JavaScript-embedded, so it requires client-side JS to render.
- Language is passed to Ecwid from Drupal's current language.
- Disabling the module removes the routes and embed but leaves `ecwid.config` unless uninstalled.
- Because credentials live in config, they can leak via config export — keep exports out of public repos.
- Test the connect flow in a staging Ecwid account before pointing production at a live store.
