# Configuration

You configure this module through **Symfony Mailer's own transport collection** —
it has no separate settings page.

## Add the Graph transport

1. Enable the module at **Administration → Extend** if you have not already.
2. Go to **Configuration → System → Mailer → Mailer Transport** (the transport
   collection, route `entity.mailer_transport.collection`).
3. **Add a new transport** and choose **MS Graph API** as the transport type.
   > Do not pick the generic **DSN** transport type for this — the list of
   > available DSN transports is hardwired in Symfony Mailer, so Graph is
   > offered as its own transport type instead.
4. Enter the client credentials from your Microsoft Entra application:
   - **Client ID**
   - **Client secret** — reference the secret you stored as an environment
     variable / Key entity rather than pasting it in plain text.
   - **Tenant ID**
5. Save the transport, and set it as the transport your mailer policies use so
   that outgoing mail is routed through Graph.

## Things to know

- **Keep the app registration narrowly scoped.** `Mail.Send` granted tenant-wide
  would let a compromised site send as anyone in the organisation. Scope the app
  to the specific mailbox with an application access policy.
- **Sender address limitation.** The module does not modify outgoing mail. While
  the sender address is taken from the message being sent, Microsoft Graph always
  sends from the primary SMTP address configured on the Entra application — a
  limitation of the Graph API itself, not this module.
- The module is deliberately minimal: it is a transport layer only and makes no
  other changes to your mail.
