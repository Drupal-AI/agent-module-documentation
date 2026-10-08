# Configuration

Orejime has two layers of configuration: the **global banner settings** (one
form) and the **consent services** (content entities you create one per cookie
category). You will usually set up the global settings once, then add a service
for each third-party tool you need consent for.

## Global banner settings

Open the module's settings form (config form route `orejime_service.settings`;
you need **Administer orejime entities**). These settings control the banner as a
whole:

- **Cookie name** *(default `orejime`)* — the name of the cookie Orejime uses to
  remember the visitor's choices.
- **Consent lifetime (days)** *(default `365`)* — how long the consent cookie
  lasts before the visitor is asked again.
- **Cookie domain** — leave blank for the current domain, or set a shared parent
  domain (e.g. `.example.com`) so one consent choice covers your subdomains.
- **Privacy policy link** *(required)* — the URL of your privacy-policy page,
  linked from the notice.
- **Must consent** — when on, the modal opens and cannot be dismissed until the
  visitor actively accepts or declines. Leave off for a softer notice.
- **Must notice** — keeps the notice on screen until acknowledged (ignored when
  *Must consent* is on).
- **Analytics (UA codes)** — a comma-separated list of Google Analytics codes for
  Orejime to manage.
- **Library CSS / JS URL** — where the Orejime library files load from. The
  defaults point at the unpkg CDN (`orejime@2.3.2`); replace them with a local
  path to self-host and avoid external requests.
- **Custom translations (YAML)** — optional YAML that overrides the library's
  built-in banner strings; validated when you save.
- **Iframe consent** — enables the flow that holds embedded iframes/videos back
  until consent is given (loads the extra iframe-consent script).
- **Logo** — an optional image URL shown in the notice.
- **Debug** — logs missing-translation warnings to the browser console; leave off
  in production.
- **Colour palette** — when enabled, your chosen colours are compiled into a
  generated stylesheet so you can restyle the banner without theming.
- **Ignore condition (request path)** — suppresses the banner on matching paths;
  the default is `/admin/*`, so the banner never covers the back office.
- **Categories** — optional visual groupings that let you title and order sets of
  services inside the modal.

Click **Save** and the banner reflects your changes on the next page load.

## Consent services

Each consent service is a content entity you manage at
**Content → Orejime services** (`/admin/content/orejime_service`). Only
**published** services appear in the banner. A service has these fields:

- **System name** — a machine name (lowercase letters, numbers, underscores) used
  to link scripts to this service via a `data-name` attribute.
- **Label** and **Description** — the human-friendly name and explanation shown in
  the consent modal.
- **Purposes** — a comma-separated list of what the cookies are used for.
- **Cookies** — the cookies this service sets, one per line. Orejime deletes these
  automatically when the visitor withdraws consent. The token `{ga}` is available
  for the Google Analytics UA code.
- **Scripts** — the filenames of *already-registered* site JavaScript you want
  gated behind this service, one per line. This references existing assets by
  filename; it does not inject new script URLs.
- **Required** — mark a service as strictly necessary so it cannot be declined.
- **Default (enabled)** — pre-tick the service in the modal.
- **Published status** — unpublished services do not appear in the banner.

Services are revisionable and translatable, so you can keep a change history and
provide translated labels/descriptions per language.

## How scripts get gated

There are three ways a script ends up waiting for consent:

1. **Automatically, for Google Analytics / Tag Manager** — Orejime recognises
   those head scripts and tags them as opt-in (under the `tracking` service).
2. **Automatically, by matching a filename** — if a registered JavaScript file's
   path matches a filename you listed in a service's **Scripts** field, Orejime
   rewrites it to opt-in.
3. **Manually** — an author marks an inline or external script with
   `type="opt-in" data-name="<service>"`, or uses an `<iframe-consent>` element
   for embeds.

## Creating services from the command line

If you provision sites from code, the Drush command `orejime:create-entity`
scripts service creation, for example:

```bash
drush orejime:create-entity custom_tracking 'Custom Tracking' \
  --description="Analytics cookies" --cookies="_ga, _gat" --default --publish
```

`--description` is required. Use `--publish` to make the service appear in the
banner, `--required` for strictly-necessary services, and `--default` to
pre-enable it. See the [`agent/`](../../agent/drush/create-entity.md) docs for the
full option list.

## Permissions

The trusted admin permission is **Administer orejime entities**, which covers the
settings form and every entity operation. Finer-grained permissions
(**Add / Edit / Delete orejime entities**, view and revision permissions) let you
delegate service authoring — but remember these editors' text is shown to every
visitor, so treat them as trusted content administrators.
