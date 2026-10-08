# Configuration

There's no global settings page. You add and configure a handler **per Webform**,
so each form can post to its own endpoint. Go to **Structure → Webforms → *your
webform* → Settings → Emails / Handlers**, click **Add handler**, and choose
**REST** or **SOAP**.

A handler fires when a submission reaches the **completed** (or **updated**)
state — that is, when someone finishes the form. You can add more than one
handler to fan out to several endpoints.

## Before you configure: turn on TLS verification

Both handlers ship with certificate verification **off**. Before you go live,
tick **Enable SSL verification** on the REST handler (and leave **Bypass SSL**
unticked on the SOAP handler).

## REST handler

The REST handler sends the submission with a raw HTTP request. Its main settings:

- **Method** — `POST` (default) or `PUT`.
- **Endpoint** (required) — the target URL. Tokens are replaced here too. A URL
  beginning with `/` is treated as a path on the current host, so you can post
  back to an internal endpoint.
- **Authentication type** — **Basic** (default) or **OAuth**.
  - For **Basic**, the **Username** and **Password** are used as HTTP
    credentials.
  - For **OAuth**, set the **OAuth token URL**; the handler fetches a
    client‑credentials bearer token (using the username/password as client ID and
    secret) and you inject it into the payload with the `[oauth:token]` token.
- **Request** (required) — the payload template. Use Drupal tokens such as
  `[webform_submission:values]`, individual field tokens, and `[oauth:token]`.
- **Headers** — one per line. If left empty, the handler sends
  `Content-Type: application/json` (Basic) or
  `application/x-www-form-urlencoded` (OAuth). Use this to send custom content
  types or API‑key headers.
- **Response** — a dotted path into the JSON response (for example `Body.Success`)
  used to decide whether the call succeeded.
- **Success value** — if set, the call counts as successful only when the
  **Response** value equals this; otherwise a truthy response value counts as
  success.
- **Message** — a dotted path to a status message in the response; it's shown to
  the user (as a status message on success, an error on failure).
- **Result values** — a JSON map of `submission_field: response.path`. Matched
  values are written back into the submission, which is then re‑saved.
- **Purge** — delete the submission after sending.
- **Enable SSL verification** — **off by default**; tick it to verify the remote
  certificate. Leave it on in production.
- **Base64 encode / Base64 string / Base64 response** — optionally base64‑encode
  the whole payload, wrap it under a named key, and/or decode a base64‑wrapped
  field in the response before parsing.
- **Debug** — echoes the sent and received data to the screen and log. Keep this
  off in production.

### Attaching files to the payload

To include an uploaded file in the request, use the
`[webform_submission:files:<element_key>]` token — it inserts the base64‑encoded
contents of the file(s) in that element (joined by a separator you can specify).

## SOAP handler

The SOAP handler talks to a WSDL or non‑WSDL SOAP service using PHP's
`SoapClient`. Its settings:

- **WSDL** — the WSDL URL, or empty for non‑WSDL mode.
- **Endpoint** (required) — used as both the SOAP location and URI.
- **Username / Password** — the SOAP login and password.
- **Request** (required) — the raw request body, with tokens replaced.
- **Response** (required) — an element name matched against the response to
  detect success (a non‑empty match means the submission posted).
- **Bypass SSL** — when ticked, disables peer/name verification and allows
  self‑signed certificates. Leave it **unticked** in production.
- **Purge** — delete the submission after sending.
- **Debug** — echoes the message and response to the screen. Keep off in
  production.

## Rewriting the outgoing REST message (developer note)

Other modules can alter the outgoing REST message before it's sent by subscribing
to the module's `RestRemoteHandlerMessageEvent`. See the sibling
[`agent/`](../agent/start.md) docs for details.
