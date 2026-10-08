# Webform Remote Handlers — agent index

Two `WebformHandler` plugins that POST completed Webform submissions to a REST or SOAP
web service. No global config page (`configure` null), no permissions of its own, no Drush.
Attach a handler per Webform under *Structure → Webforms → (webform) → Settings →
Emails / Handlers → Add handler → REST | SOAP*. Depends on `webform`.

- **REST + SOAP handler settings keys, payload/token building, auth, response handling** →
  [configure/handlers.md](configure/handlers.md)
- **`RestRemoteHandlerMessageEvent` — alter the outgoing REST message in code** →
  [api/event.md](api/event.md)

Key facts:
- Plugin ids: `rest_handler` (REST, cURL), `soap_handler` (SOAP, PHP `SoapClient`). Both
  `CARDINALITY_UNLIMITED`, category "Web services".
- Fires on `postSave()` only when the submission state is `completed` or `updated`.
- Message body = Drupal token replacement over the `request` config string; a
  `[webform_submission:files:<element>[:<separator>]]` token (defined in
  `webform_remote_handlers_token_info()`) yields base64-encoded file contents.
- Config is stored in the Webform entity (`config/schema/webform.handler.rest_handler.schema.yml`);
  no `config/install` defaults, no admin settings form.
- TLS peer verification is controlled by `enablesslverification` (REST, off by default) and
  `bypass_ssl` (SOAP); `debug` prints submission data to screen + log.
