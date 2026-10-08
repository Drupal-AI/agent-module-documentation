<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Microsoft Graph Mailer sends and receives email using the Microsoft Graph Mail service.

---

Microsoft Graph Mailer **sends and receives email via the Microsoft Graph Mail API** — a mail plugin that
delivers (and can read) mail through Microsoft 365 / Graph, using an Azure AD app (tenant id, client id, client
secret) with OAuth. It provides its own permissions, in the Mail package.

Use it to send mail via Microsoft 365. It is a mail/integration feature. Security/data handling: it authenticates
with **Azure AD OAuth app credentials** and sends mail content over the Graph API (egress). The key caveat is
credential storage: the module stores the **`client_secret` in its module configuration**
(`microsoft_graph_mailer.settings`), which is included in **config export/sync** (files, often committed to git)
and readable by anyone with config access — so **do not commit that config with the secret**, restrict who can view
config, and prefer supplying the secret via a **Key entity or environment variable** where possible. Grant the
Azure app the **least Graph permissions** needed (send-only if you don't need receive), and serve over HTTPS.
Configure the tenant/client credentials.

---

- Send/receive email via Microsoft Graph.
- Use an Azure AD OAuth app (tenant/client/secret).
- Deliver mail through Microsoft 365.
- Provide its own permissions.
- Serve mail/integration.
- Authenticate with Graph OAuth.
- STORE the client_secret in module CONFIG (exported via config-sync).
- Not commit that config with the secret + restrict config access.
- Prefer a Key entity / env variable for the secret.
- Grant the Azure app least Graph permissions (send-only if possible) + HTTPS.
- Configure the tenant/client credentials.
- Handle Graph mail.
- Send mail.
- Configure the credentials.
- Deliver email.
- Handle the integration.
- Authenticate to Graph.
- Send via Microsoft 365.
- Secure the secret.
- Provide Microsoft Graph mailing.
