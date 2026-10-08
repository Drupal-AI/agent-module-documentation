# Configuration

Configuration has two parts: connecting to your HubSpot account (the settings
form), and then placing forms on the site using one of the four embed
mechanisms.

## Connect to HubSpot

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Web services → Hubspot Forms**, or navigate directly
   to `/admin/config/services/hubspot-forms`.

Fill in the connection fields:

- **Hubspot Access Type** — choose **Access Token** (recommended) or **API Key**
  (legacy). The fields below change to match your choice.
- **Access Token path** (recommended):
  - **Hubspot Access Token** — the token from a HubSpot **Private App**.
  - **Hubspot Portal ID** — your HubSpot account/portal id. This is **required**
    on the token path, because HubSpot's newer forms API does not return the
    portal id and the embed needs it. It is prepended to every form as
    `PORTAL_ID::FORM_ID`.
- **API Key path** (legacy):
  - **Hubspot API Key** — from your HubSpot account settings. HubSpot is
    sunsetting API keys, so prefer the access token. (The special value `demo`
    loads HubSpot's example forms, handy for a quick test.) On this path the
    portal id comes back from the API per form, so you don't set it yourself.
- **Hubspot forms caching** — how long (in seconds) to cache the fetched form
  list. Default is **10800** (3 hours); `0` disables caching. Turn caching off
  temporarily while setting up so newly created HubSpot forms appear
  immediately, then restore it.

Saving the form clears the module's cached form list, so a credential change or
a new HubSpot form is picked up right away. If forms never appear, re-check the
credentials and clear caches (`drush cr`).

### Keeping the token out of version control

The access token and API key are stored as plain configuration values (there is
no Key-module integration). To avoid committing the real secret, override it
per-environment in `settings.php`:

```php
$config['hubspot_forms.settings']['hubspot_access_token'] = getenv('HUBSPOT_ACCESS_TOKEN');
```

Then set `HUBSPOT_ACCESS_TOKEN` as an environment variable on each environment.

## Embed a form — the four mechanisms

Every mechanism renders the same HubSpot embed; you pick whichever fits the
placement. Forms are identified by the `PORTAL_ID::FORM_ID` key from the
settings-driven dropdown.

1. **Block** — place the **Hubspot Forms** block via **Structure → Block layout**
   (or Layout Builder). Its configuration is a single required dropdown of your
   account's forms.
2. **Field** — add a **Hubspot Form** field (`field_hubspot_form`) to any
   fieldable bundle under *Manage fields*. Editors choose the form with the
   select widget; on display, one formatter renders the embedded form and
   another shows just the form's label. This gives each node its own form.
3. **Text-format shortcode** — enable the **Hubspot Forms** filter on a text
   format at **Configuration → Content authoring → Text formats and editors**.
   Editors can then write `[hubspot-form:FORMID]` (or a
   `<hubspotform data-form-id="…" data-portal-id="…">` tag) in filtered text.
   Because anyone who can author in that format can embed a form, keep this
   filter on **trusted** formats only.
4. **CKEditor 5 button** — add the **Insert Hubspot Form** button to a format's
   CKEditor 5 toolbar. Editors get a modal to pick a form, with a live preview.
   The button inserts the `<hubspotform …>` tag, so the **Hubspot Forms filter
   (mechanism 3) must also be enabled** on that format for the embed to render.

## Verifying the connection

If a form dropdown is empty, the module could not fetch forms — check the
credentials, confirm the Private App has form access, and clear the cache. Any
API errors are written to the `hubspot_forms` log channel (they are not shown on
the settings form).
