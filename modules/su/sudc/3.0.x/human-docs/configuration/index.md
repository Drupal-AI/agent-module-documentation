# Configuration

SearchUnify Drupal Connector is configured on a single admin form where you enter
your SearchUnify account details and map SearchUnify search configurations to URL
paths on your site.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to `/admin/config/sudc`. (There is an in-module help page at
   `/admin/config/sudc/help` if you get stuck.)

## The settings

Enter the details from your SearchUnify account:

- **CDN** — your SearchUnify CDN.
- **Provision Key** — your SearchUnify provision key. It is validated against
  SearchUnify when you save the form.
- **Endpoint** — the SearchUnify API endpoint the module calls.
- **JWT expiry** — how long the per-user JWT is valid, in minutes (the token
  lifetime; default is 180).
- **UID / Search-URL pairs** — one or more pairs mapping a SearchUnify UID (a search
  configuration) to a URL path on your site. The UIDs are validated against
  SearchUnify on save.

When you save, the module checks the provision key and UIDs against SearchUnify, so
a bad key or UID is caught immediately.

## The front-end search page

For each UID / Search-URL pair you configure, a results page appears at
**`/searchunify/<search-url>`**, rendering SearchUnify's `su_results` template for
that configuration. You can override the `su_results` template in your theme to
control the markup.

Behind the page, outbound requests to SearchUnify are made by the module's REST
service, which obtains an OAuth access token from SearchUnify using your provision
key. TLS verification is on by default; there is an SSL-verification toggle intended
for local or development use only — **leave it enabled (TLS verified) in
production**.

## The REST endpoints

The module also exposes endpoints for a browser widget or a headless front end:

- `POST /search-unify/v1/searchresultbypost` — proxies a search query to
  SearchUnify.
- `POST /search-unify/v1/su-gpt` — proxies a GPT / generative-answer request.
- `GET /search-unify/v1/search_jwt` — returns a signed JWT for the current user
  (its payload includes the user's id, email, and roles).

## Security — decide before going public

These endpoints and the results page are gated only by the **access content**
permission, which anonymous visitors have by default. Two things follow from how the
module is built, and you should decide whether they are acceptable for your site:

- **Token exposure.** The results page render data and the JWT payload carry the
  site's SearchUnify **access token** in a form the client can read (the JWT payload
  is base64-decodable). On an anonymous-accessible site, that token is disclosable to
  unauthenticated visitors.
- **Open proxy.** The `searchresultbypost` and `su-gpt` endpoints forward requests
  to SearchUnify using your stored server credentials, so anonymous users can drive
  calls through them.

If your site is public and you do not want that, **restrict the *access content*
permission** for these routes or otherwise lock the routes down before exposing the
search UI. Keep the SSL-verification toggle on in production.
