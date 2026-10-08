# Settings & OAuth key generation

## Settings — `lightning_api.settings`

- Form: `/admin/config/system/lightning/api` (route `lightning_api.settings`)
- Permission: **`administer site configuration`**

```yaml
entity_json: false   # bool: add a "View JSON" operation link on content entities
                     #       (links to the entity's JSON:API URL)
bundle_docs: false   # bool: add a "View API Documentation" operation link on bundle
                     #       config entities (content types, vocabularies, ...)
```

Read / write:

```bash
drush cget lightning_api.settings
drush cset lightning_api.settings entity_json 1 -y
drush cset lightning_api.settings bundle_docs 1 -y
```

Turning `entity_json` on triggers a router rebuild when a new bundle is created
(`hook_entity_insert`), so the JSON links resolve.

## OAuth key generation — `lightning_api.generate_keys`

- Form: `/admin/config/system/lightning/api/keys` (route `lightning_api.generate_keys`)
- Permission: **`administer simple_oauth entities`**
- Requires the **`simple_oauth`** module (`_module_dependencies: simple_oauth`); the tab/form only
  appears when it is installed.

The form (`OAuthKeyForm`, marked `@internal`) generates an OAuth2 **public/private key pair**,
writes the files (mode `0600`), and saves their paths into **`simple_oauth.settings`**
(`public_key` / `private_key`) — the keys Simple OAuth uses to sign/verify access tokens. Use it
instead of hand-running `openssl` and editing `simple_oauth.settings`.

> The generated keys are secrets. Store them outside the web root and do not commit them.

## OpenAPI docs alias

`hook_install` creates a `/api-docs` path alias pointing at the OpenAPI documentation route when
both `openapi_ui_redoc` and `openapi_jsonapi` are enabled (otherwise no alias is created).
