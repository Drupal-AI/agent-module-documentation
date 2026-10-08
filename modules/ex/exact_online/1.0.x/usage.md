<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sets up and maintains an OAuth2 API connection between Drupal and the Exact Online accounting/ERP platform using the picqer/exact-php-client library.

---

Exact Online is a piece of connection middleware: it registers your Exact Online app credentials, runs the OAuth2 authorization-code handshake, stores and automatically refreshes the resulting access/refresh tokens, and exposes an admin dashboard, settings form and log view so you can see and manage the connection. It deliberately ships no data-synchronisation features of its own — moving invoices, customers or other records between Drupal and Exact Online is always custom code written against the connected `\Picqer\Financials\Exact\Connection` object that the module's `exact_online.service` returns. You provide the Client ID and Client Secret from an app you create in the Exact Online App Store, point the app's redirect URI at the module's callback path, and the module handles token lifecycle (10-minute access tokens, 30-day refresh tokens), minutely/daily rate-limit tracking and token-expiry notifications. It depends only on Drupal core plus the picqer library and supports Drupal 10 and 11.

---

- Connect a Drupal 10/11 site to the Exact Online accounting/ERP API.
- Provide a foundation layer for a custom Exact Online integration without hand-writing the OAuth2 flow.
- Register your Exact Online app's Client ID and Client Secret through an admin settings form.
- Run the OAuth2 authorization-code grant from Drupal via the `exact_online.authorize` route.
- Receive the OAuth2 authorization callback and exchange the code for tokens automatically.
- Persist access, refresh and expiry tokens so the connection survives across requests.
- Automatically refresh an expired access token using the stored refresh token.
- Detect when the 30-day refresh token has lapsed and require re-authorization.
- Choose the Exact Online regional API base URL (defaults to the Netherlands endpoint).
- Set or auto-detect the Exact Online division number.
- View live connection status (connected / not connected) on the dashboard.
- Reset / log out of the connection to clear stored tokens.
- Track Exact Online minutely and daily API rate limits in Drupal state.
- Sleep automatically when the Exact Online minutely rate limit is hit.
- Browse a searchable log of connection and authentication events.
- Filter integration logs by type (info / warning / error) and date range.
- See the last ten log entries at a glance on the dashboard.
- Email the site address a warning when the access token is about to expire.
- Grant separate permissions for configuring, using the dashboard, and viewing logs.
- Obtain a ready-to-use `Connection` client from the `exact_online.service` service for custom sync code.
- Build custom code to push invoices or customers from Drupal into Exact Online.
- Build custom code to pull accounting data from Exact Online into Drupal.
