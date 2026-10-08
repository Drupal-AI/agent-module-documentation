<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring ZEN widgets

## Account
Register at zenwidgets.com to obtain a **website ID** and **authentication token**.

## Settings
Path: `/admin/config/services/zenwidgets`
Permission: `administer ZEN widgets configuration` (a restricted permission).
- **Website ID** (required) → config `zenwidgets.config:website_id`.
- **Authentication token** (required) → config `zenwidgets.config:authentication_token`.
- (Config also supports a `domain` override, default `https://www.zenwidgets.com`.)

## Using widgets
1. Add a **ZEN Widget** field (field type provided by this module) to any entity
   bundle via *Manage fields*.
2. Edit an entity; select the widget from the dropdown (populated from
   `<domain>/api/widgets` using the website id + token).
3. On render, the field formatter outputs `<span data-zen-widget-id=… data-zen-widget-data=…>`
   which the site-wide loader script (injected in the page bottom) hydrates.

## Security considerations
- The website ID and authentication **token are written into public page HTML**
  (the `data-zen-*` attributes on the loader `<script>`) on every page — this is
  how the client-side widget SDK is designed, but be aware the token is visible
  to all visitors.
- `getWidgets()` sends the token as a URL query parameter to the configured
  domain and logs the full URL on error. Keep `domain` on HTTPS (the default);
  never set an `http://` domain, which would expose the token in cleartext.
