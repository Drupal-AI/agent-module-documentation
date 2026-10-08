# Configuration

Configuring this module means listing the **name → public‑key** mappings that your
site will publish in `/.well-known/nostr.json`. Nothing is served until you add at
least one entry.

## Open the settings form

1. Log in as an administrator (a user who can administer site configuration).
2. Go to **Configuration → System → Nostr internet identifier (NIP‑05)**, or
   navigate directly to `/admin/config/system/nostr-id-nip05`.

## Add your identifiers

On the form you define the contents of the `nostr.json` file — the `names` mapping.
For each identifier you want to verify:

- **Name** — the local part of the handle (the part before `@`). For the handle
  `bob@example.com` on a site at `example.com`, the name is `bob`. A special name of
  `_` is conventionally used for the "root" identifier of the domain itself.
- **Public key** — the Nostr **public key in hex form** (not the bech32 `npub`
  form). This must match the public key in that user's Nostr profile
  (`set_metadata` event) for verification to succeed. Convert an `npub` to hex with
  a tool such as `https://damus.io/key/` if needed.

Add as many name/key pairs as you need, then **Save**.

## What gets published

The saved mappings are served as JSON at `/.well-known/nostr.json`. A Nostr client
requesting `…/.well-known/nostr.json?name=bob` receives:

```json
{ "names": { "bob": "<hex public key>" } }
```

Remember this endpoint is **public by design** and contains **public keys only** —
there is no secret to protect and nothing sensitive to hide here. Only add handles
you intend to advertise publicly.

## Verify

After saving, open `https://yourdomain/.well-known/nostr.json?name=<name>` in a
browser (or with `curl`). You should see the `names` object with the correct
hex public key. In a Nostr client, setting a profile's NIP‑05 field to
`name@yourdomain` should then show as verified once the key matches.
