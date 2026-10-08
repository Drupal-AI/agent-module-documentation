# Configuration

Once the module is enabled it can be configured from a settings form. Before you
turn logging up, read the security note at the end of this page — this module logs
secrets in plaintext.

## Open the settings form

1. Log in as a user with permission to administer site configuration.
2. Go to **Configuration → Development → Logging → HTTP client**, or navigate
   directly to **`/admin/config/development/logging/http_client`**.

From this form you control the module's logging behavior — for example when logging
is active and how the request/response traffic through Drupal's HTTP client is
recorded. Because the exact options can change between releases, rely on the
descriptions shown on the form itself for what each setting does, then save.

## Where the log goes

Captured entries are written to the Drupal log via Monolog. With core's Database
Logging enabled you will find them under **Reports → Recent log messages**
(`/admin/reports/dblog`); if you route logs elsewhere (a file or an external
aggregator), they land there too — which is exactly why the security note below
matters.

## Security note — read before enabling

- **Everything is logged unredacted.** Full request and response headers and bodies
  are recorded, so `Authorization` bearer tokens, `X-Api-Key` headers, and any
  secrets or personal data in the payloads end up in the log in plaintext.
- **Anyone with "access site reports" can read them**, and so can any log
  aggregator you forward Drupal logs to.
- **This is a development tool.** Never leave it enabled in production. Turn it on
  for a specific debugging session and disable (or uninstall) it afterwards.

## Save

Save the form after any change; the new logging behavior applies to subsequent
outbound requests.
