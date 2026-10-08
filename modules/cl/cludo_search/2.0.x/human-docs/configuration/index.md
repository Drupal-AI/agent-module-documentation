# Configuration

Cludo Search needs your Cludo account details before it will return any results.
Open the module's settings page (linked from the modules list under
**Configuration**); administering it requires the module's own permission.

## Enter your Cludo account details

From your Cludo dashboard, gather and enter:

- **Customer ID** — the (public) identifier for your Cludo account.
- **Engine ID** — the (public) search engine (index) within your account that Cludo
  should query.
- **Search page path** — the path on your site where the Cludo results are rendered
  (default `csearch`), so the search form knows where to send visitors.

The settings page also exposes four display toggles — disable autocomplete, hide the
results count, hide the "did you mean…" suggestions, and hide the search filters
(overlay implementation only). See Cludo's own documentation for what each affects.

## About the customer and engine IDs

These are **public** widget identifiers, not secrets. The module writes them into the
page so Cludo's browser JavaScript can run the search, so they are visible in your
page source by design — there is nothing here to store in an environment variable or
keep out of version control. (This module has no private API key or server-side
credential.)

## Place the search block

The module provides a **Cludo Search block** containing the search form. Go to
**Structure → Block layout** and place it in a region where visitors can reach it
(for example the header). Submitting it redirects the visitor to your configured
search page, where the results render. You can also send visitors straight to that
search page (default `/csearch`), which carries its own search form.

## A note on privacy and availability

Because queries are sent to Cludo, visitors' **search terms leave your site** and
are processed by Cludo — factor this into your privacy documentation. Search also
depends on Cludo being reachable; if Cludo is unavailable, search results won't
render, so consider how your site should behave in that case.
