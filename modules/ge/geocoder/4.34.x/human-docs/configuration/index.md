# Configuration

Setting Geocoder up has two parts: the **global options** on the Configuration
tab, and at least one **geocoding provider** on the Providers tab. Once a provider
exists you can geocode field values by attaching Geocoder's widget or formatter to
a field.

## Global settings

1. Go to **Configuration → System → Geocoder**
   (`/admin/config/system/geocoder`). The **Configuration** tab opens by default.

![The Geocoder Configuration tab with the presave, caching and queue options](../images/settings.png)

2. Review the three options:
   - **Geocoder Presave Disabled** — when checked, globally disables geocoding and
     reverse geocoding while entities are inserted or updated. This is useful, for
     example, to temporarily prevent geocoding during a content migration. Leave it
     unchecked for normal operation.
   - **Should we cache the results?** — when checked, Geocoder saves the result of
     each geocode / reverse-geocode temporarily in a cache so the same request is
     not sent to the provider multiple times. This cuts API calls and cost, and is
     enabled by default.
   - **Should we Queue the Geocode processes?** — when checked, geocoding is handled
     by a Queue Worker ("Geocoder Field Queue Process") and processed on Cron
     instead of inline, which reduces the delay while saving an entity. Leave it off
     unless slow saves are a problem on a high-traffic site.
3. Click **Save configuration**.

## Create a geocoding provider

Geocoder does no geocoding until you configure at least one provider. Each provider
is a saved configuration entity backed by a provider plugin (Google Maps,
Nominatim, ArcGIS, Mapbox, TomTom, and others).

1. On the Geocoder configuration page, click the **Providers** tab
   (`/admin/config/system/geocoder/geocoder-provider`).
2. Use the add-provider control to start a new provider.
3. **Choose the provider plugin.** Pick the service you want to use:
   - **Nominatim / OpenStreetMap** needs **no API key**, which makes it the easiest
     way to get started.
   - **Google Maps** (and several others) require an **API key**. Make sure you have
     installed that provider's `geocoder-php/*` Composer package (see
     [Installation](../installation/index.md)) before selecting it.
4. **Configure the provider's options.** Fill in the arguments the chosen plugin
   exposes — typically an API key plus optional settings such as locale or region.
   Enter the API key as a value drawn from an environment variable or Key entity, so
   the secret is never committed (see the note in
   [Installation](../installation/index.md)).
5. **Save** the provider.

You can create several providers. When geocoding runs, providers are tried in the
order they are supplied, so you can list a preferred provider first and a fallback
after it.

## Geocode a field

With a provider in place, the most common way to use Geocoder is to geocode one
field's value into another when an entity is saved — for example turning a
plain-text or Address field into map-ready coordinates. This is provided by the
**Geocoder Field** submodule (`geocoder_field`); enable it (and `geocoder_geofield`
or `geocoder_address` for those field types) as described in
[Installation](../installation/index.md).

Geocoder plugs into Drupal's standard **Manage form display** and **Manage
display** screens for a content type or other entity bundle:

- To geocode **as data is entered**, edit the source field on **Manage form
  display** and set its widget to the **Geocode** widget, choosing which provider(s)
  to use and which target field receives the result.
- To geocode **for output**, edit the field on **Manage display** and choose the
  **Geocode formatter**, which runs the value through your selected provider(s) and
  Dumper format when the field is rendered.

Either way you select the provider(s) you configured above, so the same providers
drive both entered-data geocoding and display-time formatting.
