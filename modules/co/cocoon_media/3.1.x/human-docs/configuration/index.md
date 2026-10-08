# Configuration

Cocoon Media Management needs your Cocoon account credentials before it can
browse or import anything.

## Open the settings form

1. Log in as a user with the **Administer Cocoon media configuration**
   permission.
2. Go to **Configuration → Media → Cocoon Media**, or navigate directly to
   `/admin/config/media/cocoon_media_settings`.

## Enter your Cocoon credentials

- **Subdomain** — your Cocoon account subdomain. The module builds the service
  URL from it (`https://{subdomain}.use-cocoon.nl/...`), so this must match your
  account exactly.
- **Username** — your Cocoon username.
- **API secret key** — the secret used to sign requests to the Cocoon SOAP
  service.

The module authenticates over HTTPS, signing each request with a SHA1 hash of
the subdomain, username, request id, and secret key. TLS verification is on by
default.

> **Keep the secret key safe.** It is stored in module configuration, which means
> it can end up in exported/committed configuration. Treat exported config as
> sensitive, and keep it out of any publicly readable location.

## Save

Click **Save configuration**. If the credentials are valid, editors can now
browse and import Cocoon assets.

## Grant the import permission

Importing assets is a separate permission from configuring the module. Grant
**Add Cocoon media items** to the roles that should be able to import — those
users add assets at `/media/add/cocoon_media_add`, searching Cocoon by tag or set
and importing selected files into the Drupal media library.

## A note on the tag-autocomplete endpoint

The module exposes a tag-autocomplete route
(`/cocoon_media/tag_autocomplete/{tag_name}`) that is **open to anonymous
users** and returns Cocoon tag names matching a prefix. This is a minor
information-disclosure surface — harmless in most setups, but worth knowing if
your Cocoon tag names themselves reveal something you would rather keep private.
