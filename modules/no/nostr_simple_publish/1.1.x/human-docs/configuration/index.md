# Configuration

Nostr Simple Publish is configured in two places: your site's **`settings.php`**
(for the keys, relay, and which field to publish) and the **Permissions** page (for
who may publish). There is no dedicated admin settings form.

## 1. Provide keys and relay in `settings.php`

Posts to Nostr must be signed, so the module needs your Nostr **public** and
**private** keys and at least one **relay**. Add settings like the following to
`settings.php` (or, better, a `settings.local.php` that isn't committed):

```php
// Paths to your Nostr key files — put these OUTSIDE the web root.
// Use the HEX-encoded keys, not the bech32 npub/nsec form.
$settings['nostr_public_key_file'] = '/path/to/public-key-file';
$settings['nostr_private_key_file'] = '/path/to/private-key-file';

// A Nostr relay to publish to.
$settings['nostr_relay'] = 'wss://nostr.pleb.network';

// Optional: which field(s) supply the note content. Defaults to 'body'.
$settings['nostr_content_fields'] = ['field_description'];
```

Notes on each setting:

- **`nostr_public_key_file` / `nostr_private_key_file`** — paths to files
  containing your keys. Store these files **outside the web root** so they can never
  be served over HTTP, and never commit them to version control. The values must be
  the **hex‑encoded** keys, not the bech32 `npub`/`nsec` versions — convert with a
  tool such as `https://damus.io/key/` or the `key-convertr` project if needed.
- **`nostr_relay`** — the WebSocket URL (`wss://…`) of the relay to broadcast to.
  Make sure your own Nostr client is connected to the same relay so your posts show
  up there too. Find relays at `https://nostr.watch`.
- **`nostr_content_fields`** — an array of machine field names whose content is
  published. Omit it to use the default `body` field.

### Protecting the private key

The private key lets anyone post to Nostr as you, so treat it as a secret. Keep the
key file outside the web root and out of version control. If you'd rather not keep
the key on disk at all, you can hold the value in an environment variable and write
it to a file (or read it) at deploy time — with DDEV, save it without committing:

```bash
ddev dotenv set .ddev/.env --nostr-private-key=<hex-private-key>
ddev restart
```

(The flag `--nostr-private-key` becomes `NOSTR_PRIVATE_KEY` in the web container.)
Whatever approach you take, never commit the private key, and rotate it if it may
have been exposed.

## 2. Grant the permissions

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Grant **publish to nostr network** to the roles that should see and use the
   "Publish to Nostr" fieldset on node forms. Keep this to trusted editors, since it
   posts publicly under your Nostr identity.
3. Optionally grant the **view debug information** permission to users who should
   see the debug output returned after a publish attempt (useful while setting up).
4. Click **Save permissions**.

## Publishing a note

1. Edit or create a node whose content lives in the configured field (the body by
   default).
2. In the **"Publish to Nostr"** fieldset on the node form, opt to publish, then
   save the node.
3. The note is signed and sent to the configured relay. The Nostr event id is
   stored in the `nostr_simple_publish` table, and **a node can only be published
   once** — you can't re‑publish the same node afterwards.

If a post doesn't appear, check that your client is connected to the same relay, and
(with the debug permission) review the debug output shown after the attempt.
