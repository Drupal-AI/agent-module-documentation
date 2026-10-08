# Configuration

Configuring Ephoto DAM has two parts: telling Drupal the URL of your Ephoto server,
and enabling the asset‑insertion tools for editors.

## Enter the Server URL (do this first)

The only Drupal‑side setting is the URL of your Ephoto Dam software. There is **no
API key or secret to enter in Drupal** — when an editor opens the asset chooser,
sign‑in with Ephoto happens in their browser against that server.

1. Go to the Ephoto DAM settings under **Configuration** (`/admin/config/ephoto_dam`).
   This form requires the *administer site configuration* permission.
2. In **Server URL**, enter the address of your Ephoto Dam server, for example
   `https://ephoto.mycompany.com/`. Use an **HTTPS** URL so the chooser and asset
   requests are encrypted in transit.
3. Save. (Drupal validates that the value is a well‑formed URL and appends a trailing
   slash if you omit it.)

## Enable asset insertion for editors

### CKEditor 5

To let editors insert Ephoto assets while writing, add the Ephoto DAM button to a
text format's editor toolbar:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Edit the text format your editors use (for example *Full HTML*).
3. In the **CKEditor 5** toolbar configuration, drag the Ephoto DAM button into the
   active toolbar.
4. Save. Editors using that format now get an Ephoto DAM control for searching the
   library and inserting an asset.

### Field (optional)

If you enabled the **Ephoto DAM Field** submodule, add an Ephoto DAM field to a
content type at **Structure → Content types → *(type)* → Manage fields**, then
configure its form and display like any other field.

## Data‑handling note

Assets are **hosted and served by Ephoto**, a third party. Drupal references them
against the Ephoto DAM service, so browsing the library and (depending on
configuration) delivering assets involves requests to Ephoto, and availability
depends on that service. Bear this dependency in mind for performance, privacy, and
uptime, and make sure your data‑processing agreements cover the integration.

## Save

Save the settings form. Then create or edit a piece of content, search your Ephoto
library, and insert an asset to confirm the connection works end to end.
