# Configuration

All of Kaleyra's settings live on one form.

## Open the settings form

1. Log in as a user with the **administer kaleyra config** permission (an
   administrator by default).
2. Go to **`/admin/config/kaleyra`** (route `kaleyra.settings`).

## Fields

- **API domain** — the base URL of your Kaleyra API region, for example
  `https://api.ap.kaleyra.io`. Use the `https://` endpoint so the request (and the
  API key it carries) is protected by TLS.
- **API key** — the key issued when you signed up for Kaleyra. This is the
  sensitive credential (see the note below).
- **Sender identifier** — the sender name or number shown on the outbound SMS.
- **Unicode mode** — how message text is encoded: `0`, `1`, or `auto`. Use `auto`
  (or the unicode option) when messages may contain non‑Latin characters or emoji
  so they're transmitted correctly.

The **API version is fixed to v4** by the form, so there's nothing to set there.

Click **Save configuration** when done. The values are stored in the
`kaleyra.settings` configuration object and used by the
`kaleyra.sms_api_adapter` service on every `send()` call.

## Keep the API key secure

The API key is stored in configuration and sent to Kaleyra as a request parameter.
Two consequences to plan for:

- **Config exports are sensitive.** Anyone who can read your exported configuration
  can read a key you typed directly into this form. Prefer supplying the key from an
  **environment variable**. With DDEV you can store it with
  `ddev dotenv set .ddev/.env --kaleyra-api-key=<value>` (never commit `.ddev/.env`)
  and reference it from `settings.php`, keeping the raw secret out of version
  control.
- **Rely on TLS.** The key travels in the request; always use the `https://` API
  domain so it's encrypted in transit.
