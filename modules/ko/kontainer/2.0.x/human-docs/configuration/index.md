# Configuration

Setting up Kontainer is four steps: connect to your Kontainer account, wire the
usage callback so Kontainer can read where assets are used, (optionally) define
CDN image conversions, and enable usage tracking. The main settings form is at
**Configuration → Media → Kontainer** (`/admin/config/media/kontainer`), behind
the **Administer Kontainer settings** permission (an administrator has it by
default).

## Step 1 — Connect the connection

On the Kontainer settings form:

- **Kontainer URL** — the base URL of your Kontainer instance, with **no trailing
  slash**.
- **Media source** — choose whether imported assets map to a **non‑CDN** Kontainer
  media type (a downloaded file field) or to the **CDN** media type (a URL field
  that references the asset on Kontainer's CDN).
- **CDN asset host** — required **only** for the CDN source. CDN media cannot be
  saved until this is set, and the status report warns you while it is missing.
- **Integration id** and **integration secret** — the credentials issued by
  Kontainer that authenticate the connection.

### Store the integration secret securely (recommended)

The integration secret is a credential and, by default, is stored in the module's
configuration (which is typically exported to git). To keep it out of your
history, hold it in an environment variable instead. With DDEV:

```bash
ddev dotenv set .ddev/.env --kontainer-integration-secret=<your-secret>
ddev restart
```

Never commit `.ddev/.env`. Reference the value from `settings.php` as a
configuration override with `getenv('KONTAINER_INTEGRATION_SECRET')`, or use a
[Key](https://www.drupal.org/project/key) entity where you can. The aim is that
the integration secret does not live in exported configuration.

## Step 2 — Wire the usage callback

Kontainer reads back where your assets are used by calling your site at
`https://<your-site>/kontainer/api/file-usages`. Register that URL as the
integration URL in your Kontainer account. Kontainer authenticates to it with an
`Authorization: Bearer base64(id:secret)` header; the module compares it to your
configured id/secret using a constant‑time check and grants a synthetic role only
on a match. If either the id or secret is empty the module refuses the request —
so make sure both are set, and keep the secret protected as above.

## Step 3 — CDN image conversions (CDN source only)

If you use the CDN source, you can define crop/resize templates as configuration
entities at `/admin/structure/cdn-image-conversion` (behind the **Administer CDN
image conversion** permission). Each conversion stores a **template id** and a
**format**; the module appends a `?d=<template_id>` transform to the CDN URL so
the image is delivered cropped/resized. Deleting a conversion resets any display
that used it back to the original image.

## Step 4 — Enable usage tracking

Go to **Entity Usage settings** (`/admin/config/entity-usage/settings`) and enable
the **Kontainer Entity Reference** tracking plugin. Usage is tracked for assets
referenced directly on nodes (paragraph nesting is followed), and the results are
what the callback endpoint reports back to Kontainer.

## Import flow (for reference)

Once configured, editors import assets through the **Media Library**: choosing a
Kontainer asset sends its details to the module (protected by a CSRF token), which
checks the editor holds the relevant `create <media type> media` permission and
then either downloads the file server‑side into `public://Kontainer` or stores the
CDN URL. After your first setup, run `drush cex` to export the created media‑type
configuration.

## Permissions

- **Administer Kontainer settings** — access the main settings form and delete
  Kontainer media types.
- **Administer CDN image conversion** — manage the CDN crop/resize conversions.

Import itself is gated by the standard per‑type **create media** permissions, so
only editors allowed to create a given media type can import into it.
