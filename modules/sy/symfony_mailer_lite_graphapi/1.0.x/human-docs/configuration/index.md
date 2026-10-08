# Configuration

You configure this module through **Symfony Mailer Lite's transport
collection** — it has no separate settings page.

## Add the Graph transport

1. Enable the module at **Administration → Extend** if you have not already.
2. Go to **Configuration → System → Drupal Symfony Mailer Lite → Transport**
   (the transport collection, route
   `entity.symfony_mailer_lite_transport.collection`).
3. **Add a new transport** and choose **MS Graph API** as the transport type.
   > Do not pick the generic **DSN** transport type for this — the list of
   > available DSN transports is hardwired in Symfony Mailer, so Graph is
   > offered as its own transport type instead.
4. Enter the client credentials from your Microsoft Entra application:
   - **Client ID**
   - **Client secret** — reference the secret you stored as an environment
     variable / Key entity rather than pasting it in plain text.
   - **Tenant ID**
5. Save the transport, and select it as the transport Symfony Mailer Lite uses
   so outgoing mail is routed through Graph.

## Things to know

- **Store credentials as secrets and scope them tightly.** The client secret
  belongs in an environment variable / Key entity, and the Entra app should be
  limited to mail-send (ideally to a specific mailbox) so a compromised site
  cannot send as arbitrary users.
- **Transport over TLS.** Requests to Microsoft Graph use HTTPS.
- **Sender address limitation.** The module does not modify outgoing mail. The
  sender address is taken from the message, but Microsoft Graph always sends from
  the primary SMTP address configured on the Entra application — a limitation of
  the Graph API itself.
