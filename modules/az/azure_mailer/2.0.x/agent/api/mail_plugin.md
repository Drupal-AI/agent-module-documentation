# The `azure_mailer` mail plugin

Source: `src/Plugin/Mail/AzureMailer.php` (`@Mail(id = "azure_mailer")`, implements
`MailInterface`, `ContainerFactoryPluginInterface`). This is a plugin **instance**, not a new
plugin type — you select it through Mailsystem, you do not subclass it.

## `format(array $message)`

Returns `$message` unchanged (no wrapping/escaping is added here — Drupal's normal mail
formatting and any Mailsystem formatter run before this).

## `mail(array $message)`

1. Reads `endpoint` and `secret` from `azure_mailer.settings`.
2. Builds the ACS payload:
   ```
   recipients.to[0].address = $message['to']
   senderAddress            = $message['from']
   headers                  = $message['headers']
   replyTo[0].address       = $message['reply-to'] ?? $message['from']
   content.subject          = $message['subject']
   ```
   Body handling:
   - if `$message['body']` is a `MarkupInterface`: `content.html` = the markup,
     `content.plainText` = `strip_tags()` of it.
   - otherwise: `content.html` wraps `$message['body'][0]` in a minimal
     `<html>…<body>` document (newlines → `<br/>`), `content.plainText` = `$message['body'][0]`.
3. `json_encode`s the payload and POSTs it with Guzzle to
   `https://<endpoint>/emails:send?api-version=2023-03-31`, `Content-Type: application/json`.
4. Signs the request with **Azure HMAC** via the `mobomo/guzzle-azure-hmac-auth`
   `AzureHMACMiddleware($secret)` pushed onto the Guzzle `HandlerStack`.

## Return / error behaviour

- Success (no Guzzle exception): returns `TRUE`. Note it does **not** inspect the ACS HTTP
  response body/status beyond exception handling.
- `GuzzleException`: adds a Drupal messenger error `Azure Communication Services error: <msg>`
  and returns `FALSE`.

## External dependency

Signing relies on `mobomo/guzzle-azure-hmac-auth`, required at `dev-main` (an unpinned dev
constraint) in the module's `composer.json` — worth pinning/reviewing in a production build.
