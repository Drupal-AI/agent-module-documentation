# Configuration

Setup has two layers: **global** options that apply to the module as a whole, and the
**per‑search‑page** settings where your engine ID and API key actually live.

## 1. Create a Google Programmable Search Engine

1. Go to [Google Programmable Search Engine](https://programmablesearchengine.google.com/)
   and create a search engine covering your site (or the domains you want to search).
2. Note its **Search Engine ID** (`cx`).
3. In the [Google Cloud console](https://console.cloud.google.com/), enable the
   **Custom Search API** and create an **API key**. Both the Custom Search JSON API
   and the Site Restricted JSON API are supported.

## 2. Global settings

1. Go to **Configuration → Search and metadata → Google JSON API**
   (`/admin/config/search/google-json-api`).
2. Review the shared values here — the **endpoint** and **documentation** URLs, plus
   presentation and end‑user messaging options that apply across your search pages.
3. Save.

## 3. Create a search page

The engine ID and API key are configured on the search page itself, not on the global
form:

1. Go to **Configuration → Search and metadata → Search pages**
   (`/admin/config/search/pages`).
2. Add a new search page of the **Google JSON API** type.
3. Enter the **Search Engine ID (`cx`)** and the **API key** for this page, and pick
   the endpoint (standard Custom Search vs. Site Restricted).
4. Configure the results presentation and messaging as you like, then save. You can
   create several search pages, each pointing at a different engine.

## Storing the API key securely

Treat the Google API key as a secret and restrict it in the Google Cloud console (to
the Custom Search API, and by referrer/IP where practical) so a leaked key can't be
abused.

- Avoid committing the key into version‑controlled configuration exports.
- Prefer keeping it in an **environment variable** and injecting it at runtime. With
  DDEV you can store such a value out of the repository using its dotenv support:

  ```bash
  ddev dotenv set .ddev/.env --google-cse-api-key=<your-key>
  ddev restart
  ```

  Then reference `getenv('GOOGLE_CSE_API_KEY')` from `settings.php` when overriding
  the search‑page configuration, so the secret stays out of the database export and
  the repo.

## Notes

- Google caps a query at **100 results**; the module's modified pager reflects that
  limit and Google's estimated result counts.
- Requests use Drupal's HTTP client with normal TLS verification and an
  admin‑configured endpoint, so there is no user‑controlled request target.
