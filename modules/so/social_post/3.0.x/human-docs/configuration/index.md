# Configuration

Social Post itself has little to configure — it provides the framework and an
integrations page, while the real setup happens in each provider module you
install. What deserves your attention here is the permissions and the stored
tokens.

## The integrations page

Go to **Configuration → Social API → Social Post**
(`/admin/config/social-api/social-post`). This page lists the provider
integrations you have installed. Each provider module (Mastodon, X, and so on)
adds its own credential form and posting behaviour; follow that module's
documentation to connect an account.

## Permissions

Social Post declares three permissions:

- **view social post user entity lists** — see the lists of connected accounts.
- **delete social post user accounts** — delete users' connections.
- **delete own social post user accounts** — delete one's own connection.

**Grant these carefully** and keep them limited to trusted roles. Site
administrators (with *administer site configuration*) are always granted access to
connection entities.

## Stored tokens

The `social_post` entity keeps each provider's OAuth access token. Protect your
backups, scope the tokens as narrowly as the provider allows, and rotate them if
you suspect exposure.
