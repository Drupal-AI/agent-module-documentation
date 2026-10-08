# Configuration

Centarro Search is configured entirely through the **Search API** admin UI — it
contributes an Elastic backend that you select when creating a Search API server.

## 1. Create a Search API server

1. Log in as a user who can administer Search API.
2. Go to **Configuration → Search and metadata → Search API**
   (`/admin/config/search/search-api`).
3. Add a **server** and choose the **Centarro / Elastic Enterprise Search**
   backend.
4. Enter your Elastic connection details:
   - the **Elastic endpoint** (your self-hosted instance or Elastic Cloud URL),
     reached over **HTTPS**;
   - the **credentials / API key** used to authenticate;
   - the **App Search engine** you want to query against.

### Keep the credentials as secrets

Do not paste the Elastic API key into configuration that gets committed. Put it in
an environment variable and reference it from a Key entity or from
`settings.php`/`getenv()`. With DDEV:

```bash
ddev dotenv set .ddev/.env --elastic-api-key=<your-key>
ddev restart
ddev exec 'test -n "$ELASTIC_API_KEY"'   # exit status 0 = set
```

## 2. Create an index and choose what to send to Elastic

1. Still under Search API, add an **index** and point it at your new Elastic
   server.
2. Choose which **content** (entity types/bundles) to index and which **fields**
   to include.
3. **Only index what your audience is allowed to see.** Content sent to Elastic
   leaves your server (external egress), and Elastic returns whatever it holds —
   so respect Search API's access handling and don't index restricted data you
   don't want exposed through search.

## 3. Index and query

- Run indexing (via the UI or `drush search-api:index`) to push documents into
  the Elastic indices.
- Build your search and category pages with **Views** on the index; the backend
  works with **facets** too.
- Business users then manage synonyms, ranking rules, curations, and analytics in
  Elastic's own Enterprise Search UI — no Drupal code changes required.

## Data-handling summary

- Indexed content and every search query are sent to the Elastic endpoint
  (external service). Confirm this is acceptable for your content.
- Authentication uses an API key/credentials over HTTPS — store them as secrets.
- Search results reflect what's in Elastic; use Search API's access controls to
  avoid surfacing content users shouldn't see.
