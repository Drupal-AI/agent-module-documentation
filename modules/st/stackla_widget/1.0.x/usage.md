<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Stackla Widget connects a Drupal site to the Stackla visual-UGC service and lets editors embed Stackla widgets on entities through a dedicated field type/widget/formatter.
---
Configuration lives at `/admin/config/services/stackla_widget/settings` (`administer stackla` permission) where you enter the Stack shortname, OAuth2 client ID and client secret, refresh interval, optional proxy, and a debug toggle. Authorization is an OAuth2 flow: an admin clicks Authorize, is sent to Stackla, and Stackla calls back to `stackla_widget.stackla_oauth` (`/admin/config/services/stackla_widget/oauth`, `use stackla` permission) with an authorization `code`; `StacklaController::stacklaOauth` exchanges it for an access token via `Credentials::generateToken` and stores the token in State. The bundled `src/Api` layer (`Request`, `Credentials`, `StacklaModel`, `Widget`, `Stack`) is a Guzzle-based SDK for the Stackla REST API, and the field plugins render selected widgets by id.

Security notes accurate to this code: the SDK's HTTP client sets `'verify' => FALSE` (disables TLS certificate verification) whenever a proxy is enabled — see `src/Api/Request.php:105` — so with proxying on, the OAuth token exchange that carries `client_secret` and the returned access token are exposed to man-in-the-middle. Separately, when `debug_mode` is enabled the OAuth controller logs the full `client_id`, `client_secret`, access code and callback in cleartext to the logger (`StacklaController.php` ~line 536). The client secret is stored in module config and shown in a plain textfield. The OAuth callback route is permission-gated (`use stackla`), not anonymous. Setup: create a Stackla plugin config, copy the callback URL into Stackla, paste the client id/secret back into Drupal, and Authorize.
---
- Configure Stack shortname, client ID and secret at the settings form.
- Copy the module's callback URL into the Stackla plugin config.
- Run the OAuth2 Authorize flow to obtain an access token.
- Reauthorize or revoke the Stackla authorization from the form.
- Set the widget refresh interval (seconds; -1 = every cron).
- Enable an outbound proxy and set the proxy URL.
- Toggle debug mode to log verbose request details (dev only).
- Add the Stackla widget field to a content type.
- Select a Stackla widget by id on an entity edit form.
- Render an embedded Stackla UGC widget on a node.
- List available Stackla widgets from the account.
- Fetch a widget's embed/iframe markup by id.
- Grant `administer stackla` to config admins and `use stackla` to editors.
- Store the Stackla access token in State via the service.
- Unset/clear the stored access token to force re-auth.
- Cache widget options to reduce API calls.
- Disable debug mode in production to stop secret logging.
- Avoid enabling the proxy path since it disables TLS verification.
- Review `src/Api/Request.php:105` before trusting proxied traffic.
- Rotate the client secret if debug logs may have captured it.
- Use the Guzzle-based SDK classes to script Stackla API calls.
