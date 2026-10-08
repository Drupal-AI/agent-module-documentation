# Configuration

This channel is configured by defining a **chat transport** for each service you
want to reach and, most importantly, keeping that transport's **credentials**
out of your codebase. The transport model comes from Symfony's Chatter component;
the base [Notifier](https://www.drupal.org/project/notifier) module supplies the
plumbing this channel plugs into.

## Chat transports and their DSNs

Each chat service is described by a **DSN** — a connection string that names the
service and carries the credential it needs. Depending on the service that is a
**webhook URL, a bot token, or an API key**. For example, a Slack transport needs
a Slack token/webhook, a Discord transport needs a Discord webhook, and so on.
Discord, Slack, and Mercure are the transports the maintainer has tested; the
rest depend on the corresponding Symfony transport being installed.

Whatever the service, the DSN **embeds a secret** — treat it as one.

## Store chat credentials as secrets — never commit them

1. Set the value with DDEV's dotenv helper so it stays out of version control:

   ```bash
   ddev dotenv set .ddev/.env --chat-webhook=<value>
   ddev restart
   ```

   The flag `--chat-webhook` becomes the environment variable `CHAT_WEBHOOK`.
   Do **not** commit `.ddev/.env`.

2. Reference the variable at runtime rather than pasting the secret into
   configuration — via a [Key](https://www.drupal.org/project/key) entity backed
   by the environment provider where supported, or `getenv('CHAT_WEBHOOK')` from
   `settings.php` otherwise.

## Secure endpoints and egress

- Use **secure (TLS)** endpoints so tokens and message content are never sent in
  the clear.
- Delivering to a chat service means Drupal makes **outbound requests** to that
  service — confirm your environment's egress/firewall rules permit reaching it.
- Chat messages can carry **user data**; be deliberate about what you post and to
  which channel, since a chat room may be visible to more people than you expect.
