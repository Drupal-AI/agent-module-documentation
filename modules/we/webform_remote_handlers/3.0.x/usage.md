Webform Remote Handlers adds two Webform handler plugins — REST and SOAP — that POST each completed Webform submission to an external web service using an admin-defined endpoint, payload template, and authentication.

---

The module registers two `WebformHandler` plugins (`rest_handler`, `soap_handler`) that you attach to a Webform under *Emails / Handlers*. Each handler stores its own configuration (endpoint URL, HTTP method, a token-enabled message body, authentication, headers, etc.) in the Webform's config. On `postSave()` — when a submission reaches the `completed` or `updated` state — the handler builds the message by running Drupal token replacement over the configured `request` template (`[webform_submission:values]`, custom tokens, and a provided `[webform_submission:files:...]` base64 token for uploaded files), then sends it: the REST handler uses raw cURL (`POST`/`PUT`, Basic or OAuth2 client-credentials auth, optional custom headers, optional base64 wrapping), the SOAP handler uses PHP `SoapClient`. Responses can be parsed with a dotted path (`Body.Success`) and compared to a success value; matched values can be written back into the submission (`result_values`), a status/error message shown, and the submission optionally purged after a valid response. A `debug` toggle echoes sent/received data to the screen and log. A `RestRemoteHandlerMessageEvent` lets other modules rewrite the outgoing REST message before it is sent. SSL verification is an opt-in checkbox on the REST handler (the SOAP handler has a "Bypass SSL" option), and the debug toggle prints submission data to the UI.

---

- POST every Webform submission to an external REST API as JSON.
- Send Webform submissions to a legacy SOAP web service via WSDL.
- Forward contact-form or lead submissions into a CRM or ticketing system.
- Build a custom JSON payload with tokens like `[webform_submission:values]`.
- Include individual field values in the payload using submission tokens.
- Attach uploaded files to the payload as base64 using the `[webform_submission:files:<key>]` token.
- Authenticate to the remote endpoint with HTTP Basic auth (username/password).
- Authenticate with OAuth2 client-credentials, fetching a bearer token from a token URL and injecting it via `[oauth:token]`.
- Override the default request headers (e.g. custom `Content-Type` or API keys).
- Send an `application/x-www-form-urlencoded` body instead of JSON.
- Use `POST` or `PUT` as the HTTP method for the REST call.
- Base64-encode the whole payload and wrap it under a named key.
- Decode a base64-wrapped response field before parsing it.
- Parse a nested response value with a dotted path (e.g. `Body.Success`).
- Treat the response as success only when a field equals a specific value.
- Write values returned by the remote server back into the submission record.
- Show the remote server's status message to the user after submit.
- Automatically delete (purge) the submission after a successful remote post.
- Attach multiple REST/SOAP handlers to one Webform to fan out to several endpoints.
- Rewrite the outgoing REST message from custom code via `RestRemoteHandlerMessageEvent`.
- Temporarily enable debug mode to inspect exactly what is sent and received.
- Post submissions back to an internal path on the same host (leading-slash endpoint).
