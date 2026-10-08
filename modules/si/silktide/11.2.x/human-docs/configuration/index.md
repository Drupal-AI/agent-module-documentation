# Configuration

Silktide has a single, minimal settings form, at **Configuration → Web Services →
Silktide** (`/admin/config/services/silktide`). It's gated by the **Configure
Silktide** permission, so grant that to whoever manages the integration.

## The one setting: API key

The form has a single field:

- **API key** — the key from your Silktide account, found under **Settings →
  Integrations** in Silktide. It's required (up to 40 characters) and is saved
  trimmed. This one key does double duty: it authenticates the notifications sent
  to Silktide's API, and it's used to encrypt the editor deep‑link meta tag.

That's the only thing to configure. There is no per‑content‑type toggle — the
integration applies to all published nodes.

### Setting it from Drush

You can set the key without the UI:

```bash
drush config:set silktide.settings apikey YOUR_KEY -y
```

## What happens once a key is set

With a valid API key in place, two behaviors switch on automatically:

1. **Re‑scan notifications.** When a **published** node is created or updated, the
   module sends its URL to Silktide's API (`https://api.silktide.com/cms/update`),
   which re‑crawls that page within seconds. Only published nodes trigger this —
   drafts and unpublished content are skipped. Successes and failures are written
   to the **silktide** log channel, so you can troubleshoot there. (With no key
   or an invalid one, the call is simply rejected and logged; nothing useful
   leaves the site.)

2. **Editor deep‑link meta tag.** On node pages, the module adds an encrypted
   `silktide-cms` meta tag containing the node's edit‑form URL. It's encrypted
   with your API key (which is why the OpenSSL extension is required), so only
   your paired Silktide account can decode it. This is what lets the Silktide
   toolbar verify your CMS and jump an editor straight from a scanned page to the
   Drupal editor.

## Turning the integration off

There's no separate "disable" switch. To stop the site contacting Silktide,
either clear the **API key** field or uninstall the module — with no key, no
notifications are sent and no useful data leaves the site.

## A note on the outbound call

By design, the site makes an outbound HTTP request to Silktide's servers on every
publish or update of a published node. This is expected behavior for the
integration, not a fault — but it's worth knowing if your site has strict
egress/privacy requirements.
