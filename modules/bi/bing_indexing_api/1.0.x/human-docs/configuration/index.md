# Configuration

Bing Indexing API needs your Bing Webmaster credentials, and then you choose when it
submits URLs. All three screens require the `administer bing index api` permission —
grant it under **People → Permissions** (`/admin/people/permissions`) to the roles
that should manage indexing.

## 1. Credentials

Go to **Configuration → Web services → Bing Indexing API**
(`/admin/config/services/bing-index-api`) and set:

- **API key** — your Bing Webmaster API key.
- **Base domain** — your site URL, used as the `siteUrl` sent to Bing.

### About the API key

For this Bing API the key is stored in the module's configuration, and it is only
ever sent to Bing over HTTPS (with normal TLS verification). It is still a
credential, so avoid exposing it: keep it out of any configuration you publish
publicly, and where you manage configuration in version control, supply the value
from an environment variable rather than committing it. With DDEV you can store it as
an environment variable:

```bash
ddev dotenv set .ddev/.env --bing-api-key=YOUR_KEY_HERE
ddev restart
```

Never commit `.ddev/.env`.

## 2. Settings — choose the triggers

Go to **Configuration → Web services → Bing Indexing API → Settings**
(`/admin/config/services/bing-index-api/settings`). The flags there decide which node
events submit a URL:

- **On create/update** — submit when a node is created or updated (with an option to
  restrict to published nodes only).
- **On unpublish** — submit when a node changes from published to unpublished.
- **On delete** — submit when a node is deleted (with an option to restrict to
  published nodes only).

Turn all of these off if you would rather submit URLs only manually via the bulk
form.

## 3. Bulk update

Go to **Configuration → Web services → Bing Indexing API → Bulk update**
(`/admin/config/services/bing-index-api/bulk-update`) to submit many URLs in a single
call — handy for pushing a curated list of important URLs after a launch.

## 4. Programmatic submission (optional)

Custom code can reindex a specific URL through the client service:

```php
\Drupal::service('bing_indexing_api.client')
  ->reindexUrl($node->toUrl()->setAbsolute()->toString());
```

`reindexUrl()` accepts a single URL string or an array of URLs.

## Security notes

- Submissions are outbound only, sent to Bing over HTTPS; there are no inbound or
  anonymous endpoints.
- All admin screens require `administer bing index api` — grant it only to trusted
  roles.
- Treat the API key as a credential and keep it out of public configuration.
