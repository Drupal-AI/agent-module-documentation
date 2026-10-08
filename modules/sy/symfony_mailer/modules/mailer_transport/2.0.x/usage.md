Mailer Transport provides a configuration UI and `mailer_transport` config entities for defining how Mailer Plus actually sends email — SMTP, Sendmail, native PHP mail, a raw DSN, or a null (discard) transport — and choosing a site default.

---

Symfony Mailer sends through a **transport**, expressed as a DSN. This submodule (a hard
dependency of Mailer Plus) lets site builders create and manage those transports as
exportable config entities instead of hand-writing DSNs. Each transport is a
`mailer_transport` config entity built from a **TransportUI** plugin: `smtp` (host, port,
user, password, encryption), `sendmail` (with command validation), `native` (PHP's configured
mailer), `dsn` (paste any Symfony DSN, e.g. for SendGrid/Mailgun/Amazon SES), and `null`
(discard, useful on staging). One transport is marked the **default**; individual emails can
be routed to a specific transport via a Mailer Policy `transport` adjuster. A `MultiTransport`
/ unified factory dispatches each email to its chosen transport. Managed at Configuration →
System → Mailer Plus → Transport, everything is standard config so it deploys between
environments (keep secrets out of exported config). Developers can add new transport UIs with
the `#[TransportUI]` attribute or alter the set via `hook_mailer_transport_info_alter()`.

---

- Configure an SMTP server (host, port, username, password, TLS) for outgoing mail.
- Route all mail through a transactional provider via a DSN (SendGrid, Mailgun, SES).
- Use the local Sendmail binary as the transport.
- Fall back to PHP's native mail() transport.
- Set a null transport on staging so no real emails are sent.
- Choose which configured transport is the site default.
- Switch the whole site's mail delivery by changing the default transport.
- Send a specific email type through a different transport via a policy adjuster.
- Store transport configuration as exportable, deployable config entities.
- Paste a raw Symfony Mailer DSN for an unsupported provider.
- Validate the Sendmail command before saving to avoid misconfiguration.
- Separate a high-volume newsletter transport from transactional mail.
- Test SMTP credentials by sending a verification email from Mailer Plus.
- Disable outgoing email quickly by switching the default to null.
- Manage multiple transports for different environments in one config set.
- Encrypt SMTP connections by selecting TLS/SSL in the SMTP UI.
- Add a custom TransportUI plugin for an in-house delivery service.
- Alter available transport types with `hook_mailer_transport_info_alter()`.
- Set a per-transport timeout or authentication mode through its UI.
- Migrate from the SMTP/Mimemail contrib modules to a maintained transport UI.
- Point local development at a catch-all mailbox (e.g. Mailpit) via DSN.
- Keep transport secrets in environment variables while deploying the entity.
