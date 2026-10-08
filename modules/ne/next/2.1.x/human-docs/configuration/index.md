# Configuration

Setting up the integration has three parts: register your Next.js **site**, map the
**content** that should preview and revalidate against it, and confirm the **global**
settings. All of it lives under **Configuration → Web services → Next.js**
(`/admin/config/services/next`), gated by the *Administer site configuration*
permission.

> **Read the secrets note first.** A Next.js site stores two shared secrets. Handle
> them the way you would any password — see [Keeping secrets out of
> config](#keeping-secrets-out-of-config) at the end before you paste anything in.

## 1. Register a Next.js site

Open the collection page (**Configuration → Web services → Next.js**) and add a site.
Each site describes one front-end app:

- **Label** and **machine id** — a name like "Blog" and an id like `blog`.
- **Base URL** — the live front-end URL, e.g. `https://blog.example.com`.
- **Preview URL** — the endpoint Drupal POSTs a preview request to, typically
  `<base>/api/preview`.
- **Preview secret** — the shared secret used to authenticate that preview request.
- **Revalidate URL** — the front-end revalidation endpoint, typically
  `<base>/api/revalidate`.
- **Revalidate secret** — the shared secret for revalidation calls.

Save the site. Each site then has an **Environment variables** page
(`/admin/config/services/next/sites/{site}/env`) that prints the exact env values —
including these secrets — to copy into your Next.js app's own environment. The
Drupal side and the Next.js side must use the **same** secret values so the two ends
trust each other.

## 2. Map content to the site

Switch to the **Entity types** tab and add a mapping for each content type you want
to preview/revalidate (the mapping's id is `entity_type.bundle`, e.g. `node.article`).
For each mapping you choose:

- **Site resolver** — which Next.js site(s) this content belongs to:
  - **Site selector** — you pick the site(s) manually from a list. Simple single- or
    multi-site setups use this.
  - **Entity reference field** — the target site is read from an entity reference
    field on the content, for per-item routing across many sites.
- **Draft enabled** — turn on draft mode for this type so editors see live drafts in
  the front end.
- **Revalidator** — how the front end is told to rebuild when this content changes:
  - **Path** — revalidate the entity's own page, plus any **additional paths** you
    list (one per line, e.g. `/blog`).
  - **Cache tag** — revalidate by cache tag (the entity tag, its list tag, and any
    additional tags) instead of by path.
  - (or none, if a type should not trigger revalidation.)

Save the mapping. From now on, saving or deleting an entity of that type runs its
revalidator and notifies the site.

## 3. Global settings

The **Settings** tab (`/admin/config/services/next/settings`) holds site-wide
defaults:

- **Site previewer** — how Drupal renders the decoupled preview on the entity page.
  The built-in option is **iframe**, which embeds the front end in an iframe; you can
  set its **width**, and whether it **syncs the route** as editors navigate. If
  content moderation is enabled, the moderation control form is added above the
  iframe automatically so editors can change state without leaving the preview.
- **Preview URL generator** — how the secure preview URL is built:
  - **Simple OAuth** *(default)* — role-scoped access via OAuth; you set the
    **secret expiration** in minutes (how long a preview link stays valid, default
    30).
  - **JWT** — user-scoped access via JSON Web Tokens (available when the `next_jwt`
    submodule is enabled).
- **Debug** — extra logging while you are wiring things up.

Anonymous or role-less visitors are given the live front-end URL rather than a
preview URL, so previews stay restricted to editors.

## How preview and revalidation behave

Once configured: when an editor opens a mapped entity, its Drupal page is replaced by
the site previewer (the iframe), which loads an authenticated preview URL built by the
preview URL generator. When any mapped entity is inserted, updated or deleted, the
module runs that type's revalidator, which calls the site's revalidate endpoint (using
the revalidate secret) so the front end rebuilds the affected pages. Two POST routes,
`/next/draft-url` and `/next/preview-url`, receive and validate incoming preview
requests from the Next.js app. The services, events and plugin internals are in the
[`agent/` docs](../agent/start.md).

## Keeping secrets out of config

The **preview secret** and **revalidate secret** are credentials. If you export
configuration to Git (as most managed Drupal projects do), pasting the raw secrets
into the site form would commit them to version control — avoid that.

Recommended pattern, matching this project's conventions:

1. Store each secret in an **environment variable** rather than typing it into the
   form. With DDEV, set it once and restart so the web container picks it up:

   ```bash
   ddev dotenv set .ddev/.env --next-preview-secret=SUPER_SECRET_VALUE
   ddev dotenv set .ddev/.env --next-revalidate-secret=ANOTHER_SECRET_VALUE
   ddev restart
   ```

   Keep `.ddev/.env` out of version control.

2. Feed those variables into the `next_site` configuration at runtime rather than
   storing the literal values — for example via a settings.php config override that
   reads `getenv('NEXT_PREVIEW_SECRET')` / `getenv('NEXT_REVALIDATE_SECRET')` into
   `next.next_site.<id>` — so the exported config never contains the secret.

3. Use the **same** secret values in your Next.js app's environment (the site's
   *Environment variables* page shows exactly what it expects), so both ends
   authenticate against the identical value.

This keeps the two ends in sync while ensuring the secrets live only in the
environment, never in committed config.

## Uninstalling

The module blocks uninstall while the active preview URL generator or previewer
plugins are still in use. Reset those to defaults (or remove your site mappings)
before uninstalling.
