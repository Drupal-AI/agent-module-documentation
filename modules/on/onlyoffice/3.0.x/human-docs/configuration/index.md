# Configuration

Configuring ONLYOFFICE Connector comes down to two fields — where your Document
Server lives, and the shared JWT secret that makes the connection between Drupal
and that server trustworthy. The second field is the one that matters for
security, so do not skip it.

## Open the settings form

1. Log in as an administrator (the module provides its own permissions — grant the
   ONLYOFFICE administration permission only to trusted administrators).
2. Open the settings form from the **Extend** page (**Configure** next to
   *ONLYOFFICE Connector*) or the **Configuration** section of the admin menu. It
   is registered as `onlyoffice.settings_form`.

## Document Server URL

- **Document Server address** — the URL of your running ONLYOFFICE Docs instance
  (for example `https://docs.example.com/`). Use **HTTPS** so documents and tokens
  are not sent in the clear. Drupal loads the editor from this address and posts
  save callbacks are validated against it, so it must be correct and reachable
  from both the user's browser and your server.

## JWT secret — set this, do not leave it blank

- **JWT secret (`doc_server_jwt`)** — a shared secret used to sign and verify the
  JSON Web Tokens exchanged between Drupal and the Document Server. **This is the
  single most important setting on the page.**

  When a secret is set, the module's public save callback
  (`/onlyoffice-callback/{key}`) verifies the JWT that the Document Server sends
  with each save (read from the request body's `token` or the `Authorization`
  header) and **rejects any callback that arrives without a valid token**. That is
  what stops an attacker from forging a save request and overwriting your files.

  The field is documented as "leave blank to disable" — and leaving it blank
  **disables JWT verification on the callback**, which you do not want in
  production. Always set it, and set the **same** secret on the Document Server so
  that it, too, requires JWT.

### Store the JWT secret securely

Treat the JWT secret as a credential — keep it out of exported configuration and
out of Git. With DDEV, store it in an environment variable and restart:

```bash
ddev dotenv set .ddev/.env --onlyoffice-jwt-secret=<your-secret>
ddev restart
```

That exposes it inside the container as `ONLYOFFICE_JWT_SECRET` (and keeps
`.ddev/.env` unversioned). Confirm it is present without printing it:

```bash
ddev exec 'test -n "$ONLYOFFICE_JWT_SECRET"'   # exit status 0 means it is set
```

Then feed the value into the module's JWT‑secret setting from the environment
(for example via `getenv('ONLYOFFICE_JWT_SECRET')` in `settings.php`, or a Key
entity) rather than pasting it into configuration that gets committed.

## A note on the callback's second protection

Even with the JWT secret set, the callback URL's `{key}` is independently signed
with an HMAC derived from your site's `hash_salt` and `private_key`, so the link
itself cannot be forged. The JWT verification and the HMAC key work together —
keep the JWT secret configured so both layers are active.

## Editing permissions

The connector does not manage who may edit which document — that is governed by
Drupal's normal **Media** permissions. Review **People → Permissions** to make sure
only the intended roles can edit the media files that ONLYOFFICE will open.

## Save

Save the form. Then test end to end: open an office file under **Content → Media**,
choose **Edit in ONLYOFFICE**, make an edit, and confirm it saves — a successful
save proves the Document Server URL, the JWT secret, and the callback are all
correctly wired.
