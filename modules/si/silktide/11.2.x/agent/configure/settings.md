# Configure Silktide

## Settings form

- Route `silktide.form` → path `/admin/config/services/silktide` (menu: Config → Web Services → Silktide).
- Access: permission **`silktide configuration`** ("Configure Silktide" — not `restrict access: true`).
- One field: **API key** (`apikey`, textfield, max length 40, required). Get it from the Silktide
  account under Settings → Integrations. Saved trimmed into `silktide.settings`.

## Config object `silktide.settings` (schema `silktide.schema.yml`)

| Key | Type | Meaning |
|---|---|---|
| `apikey` | text | The Silktide API key; used for the API POST and to encrypt the meta tag. |
| `lastnotified_time` | timestamp | Last notification time (declared in schema). |

Set it via Drush instead of the UI:
```bash
ddev drush config:set silktide.settings apikey YOUR_KEY -y
```

## Runtime behavior (what enabling the module does)

**1. Phone-home on content change** (`silktide.module` + `SilktideService`):
- `hook_entity_insert` / `hook_entity_update` fire only for `node` entities that are **published**.
- They dispatch `SilktideEvent` with the node's absolute canonical URL.
- `SilktideService::notify()` (event subscriber) POSTs `application/x-www-form-urlencoded`
  `{apiKey, urls[]}` to **`https://api.silktide.com/cms/update`** using the core `http_client` (Guzzle),
  user-agent `SilktideDrupal/1.7`. This is an intentional outbound call to Silktide's servers on every
  publish/update. Success and failure are logged to the `silktide` channel; with no/invalid key the API
  returns 403 (harmless log noise).

**2. Editor deep-link meta tag** (`silktide_page_attachments`):
- On any route that resolves a `node`, adds `<meta name="silktide-cms" content="…">`.
- Content = JSON `{editorUrl: <edit-form absolute URL>}` encrypted with **AES-256-CBC** using the API
  key, packaged as base64(`IV . HMAC-SHA256 . ciphertext`). Lets the Silktide toolbar verify the CMS
  and jump to the Drupal editor. Requires `ext-openssl`.

## To disable the integration

Uninstall the module, or clear `apikey` — with no key the encryption/notification simply logs and no
useful data leaves the site. There is no per-content-type toggle; all published nodes are notified.
