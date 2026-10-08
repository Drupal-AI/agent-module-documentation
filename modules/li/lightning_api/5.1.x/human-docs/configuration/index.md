# Configuration

Content API has two small pieces you configure: a settings form with two toggles,
and (when Simple OAuth is installed) an OAuth key-generation form. The real API
endpoints come from core JSON:API and are available as soon as the module is
enabled.

## The settings form — two toggles

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → System → Lightning → API**, or navigate directly to
   `/admin/config/system/lightning/api`.

The form has two checkboxes (both off by default):

- **View JSON** (`entity_json`) — adds a **"View JSON"** link to content entities'
  operations. It links to that entity's JSON:API URL, so editors can preview
  exactly what the API returns for a node or other entity. (Turning this on
  triggers a router rebuild when new bundles are created, so the JSON links always
  resolve.)
- **View API Documentation** (`bundle_docs`) — adds a **"View API Documentation"**
  link to bundle configuration entities (content types, vocabularies, and so on).

Click **Save**. The links then appear in the relevant operations dropdowns.

## Generating OAuth keys (only with Simple OAuth)

If you installed **Simple OAuth** for token authentication, this module gives you a
one-click way to generate the signing keys it needs.

1. Go to **Configuration → System → Lightning → API → Keys**
   (`/admin/config/system/lightning/api/keys`). This tab only appears when Simple
   OAuth is installed.
2. You need the **Administer simple_oauth entities** permission.
3. Submit the form. It generates an OAuth2 **public/private key pair**, writes the
   files with restrictive permissions, and saves their paths into Simple OAuth's
   settings (`simple_oauth.settings`) — the keys Simple OAuth uses to sign and
   verify access tokens.

This replaces hand-running `openssl` and editing Simple OAuth's config yourself.

> **The generated keys are secrets.** Store them outside the web root and never
> commit them to version control.

## Browsable API docs at /api-docs (optional)

If the **OpenAPI JSON:API** module and the **ReDoc** UI were present when you
installed Content API, the module created a `/api-docs` path alias pointing at the
generated API documentation — a memorable URL for developers to explore the API.
If you add those modules later, you can create the alias yourself, or point your
own alias at the OpenAPI documentation route.

## Putting it together

To operate the API end to end:

1. Content is already exposed over JSON:API at `/jsonapi/...` (from the core
   dependency).
2. Optionally enable Simple OAuth and generate keys via the key form above for
   authenticated access.
3. Toggle the two "View JSON" / "View API Documentation" links to taste.
4. Optionally add OpenAPI + ReDoc/Swagger for interactive docs at `/api-docs`.

See the [`agent/`](../agent/start.md) docs for the full list of moving parts and
where each is configured.
