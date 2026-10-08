# Configuration

Configuring Notifier means defining the **transports** that each channel uses to
reach an external service, and — the part that deserves real care — handling the
**credentials** those transports carry. This page focuses on doing that safely;
the specific fields depend on which channel module you have enabled (see the
[Chat Channel](https://www.drupal.org/project/notifier_chat_channel) and
[Email Channel](https://www.drupal.org/project/notifier_email_channel) guides).

## Transports and DSNs

Following the Symfony Notifier model, a transport is described by a **DSN** — a
connection string that identifies the provider and carries the details needed to
authenticate with it (an API key, a token, a webhook URL, or SMTP credentials,
depending on the service). When you send a message, Notifier hands it to the
matching transport, which delivers it.

The important thing to understand is that a DSN usually **embeds a secret**. That
secret must never be committed to your repository or pasted into configuration
that gets exported to code.

## Store credentials as secrets — never commit them

Keep every provider credential in an **environment variable**, and reference it
rather than hard‑coding it:

1. Set the value with DDEV's dotenv helper (this keeps it out of version
   control):

   ```bash
   ddev dotenv set .ddev/.env --notifier-secret=<value>
   ddev restart
   ```

   The flag `--notifier-secret` becomes the environment variable
   `NOTIFIER_SECRET`. Do **not** commit `.ddev/.env`.

2. Where the module or Symfony supports it, prefer a **Key** entity (from the
   [Key](https://www.drupal.org/project/key) module) backed by the environment
   provider, so the secret is read from the environment at runtime and never
   stored in config. Otherwise, reference the variable directly from
   `settings.php` with `getenv('NOTIFIER_SECRET')`.

## Use secure endpoints and mind egress

- Always use **secure (TLS) DSNs/endpoints** so credentials and message content
  are not sent in the clear.
- Sending notifications means Drupal makes **outbound requests** to third‑party
  services — make sure your environment's egress rules allow reaching them.
- Remember that notifications carry **user data** (recipient addresses and
  message content). Notifier has no access‑control role, so it is on you to
  decide what is appropriate to send and to whom.
