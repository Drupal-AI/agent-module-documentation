# Configuration

N1ED is configured in two places: mostly **per text format**, with a small
**advanced** form for a couple of global options.

## Enabling N1ED on a text format (the main step)

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) and edit a CKEditor-based format. N1ED lives inside
the CKEditor toolbar / plugin configuration; enabling it toggles the ecosystem on for
that format. On the Text formats overview an **N1ED / Flmngr badge** marks the formats
where it is active.

Remember the module already auto-enabled itself on Full-HTML-style formats during
install. Only enable it on formats used by **trusted** content editors — it is a
full page builder plus a file manager, not something to expose on a public comment
form.

## The API key

N1ED loads its editor from the cloud, keyed by an API key stored in the module's
settings (`n1ed.settings`):

- The shipped default is a **public demo key** (`N1D824RR` / `FLMN24RR`). It is
  documented as a demo key — it is not a secret and does not protect your site, but
  it also does not unlock your own account's features.
- To go to production, create an N1ED account, get your API key, and set it. The
  module accepts it via its "set API key" admin action (which posts to
  `/admin/config/n1ed/setApiKey`, guarded by the *Administer n1ed configuration*
  permission and a CSRF token). N1ED then contacts `cloud.n1ed.com` to resolve your
  integration type (`n1ed`, `flmngr`, or `txt42`) and caches it.

Treat your real API key as an account credential — it links your site to your N1ED
account.

## Advanced settings form

At **Configuration → Content authoring → N1ED** (`/admin/config/content/n1ed`,
requires *Administer site configuration*) you can set just two advanced options:

- **Version** — pin the N1ED editor to a specific version, or leave blank to track
  the latest.
- **Cache server URL** — point N1ED at a custom cache server, or leave blank to
  disable caching.

The form warns that these are for advanced users.

## Flmngr file-manager options

Two toggles control the Flmngr file manager (set via the *Administer n1ed
configuration* endpoints):

- **Use Flmngr on file fields** *(on by default)* — attach the Flmngr file manager
  to core image and file field widgets, for users who hold *Administer flmngr files*.
- **Use legacy Flmngr backend** *(off by default)* — switch to the older
  `/flmngr-legacy` backend instead of `/flmngr`.

## Permissions

Two permissions (at *People → Permissions*):

- **Manage files and images** (`administer flmngr files`) — gates the Flmngr backend
  and the file-field integration. It is **not** marked "restrict access", so it is
  intended to be grantable to content editors. Holders can list, upload, rename,
  move, copy, delete, and resize files under `public://flmngr`.
- **Change N1ED settings** (`administer n1ed configuration`) — gates the API-key and
  Flmngr toggle actions.

