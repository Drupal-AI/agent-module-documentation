# Configuration

Setting up Location Signpost has three parts: storing the OS Places API key
securely, defining your areas and their signpost links, and placing the block (or
paragraph) where visitors will use it. You'll find the module's settings under
**Configuration** in the admin menu once the module is enabled.

## Step 1 — store the OS Places API key as a secret

The **OS Places API key must be treated as a secret.** Do not paste it into a
setting that gets exported in your configuration. The recommended approach is the
**Key** module:

1. With DDEV, save the value as an environment variable:

   ```bash
   ddev dotenv set .ddev/.env --os-places-api-key=<your-key>
   ddev restart
   ```

   Keep `.ddev/.env` out of version control.

2. Create a Key entity that reads from that environment variable (at **Configuration
   → System → Keys**, or with `drush key:save …` using the environment key
   provider).

3. In the Location Signpost settings, select that Key entity as the source of the
   OS Places API key.

If you are not using the Key module, at minimum keep the key out of exported
configuration and ensure the API is called over HTTPS.

## Step 2 — define your areas

Area identification works by matching a postcode's ONS **MSOA** code (looked up via
postcodes.io) against the MSOA codes you configure. For each area you want to
support:

- List the **MSOA code(s)** that belong to that area.
- Configure the **signpost links** — the local-service links shown to a visitor
  whose postcode falls in that area.

This mapping is what turns "a visitor in this postcode" into "these are the
services for you."

## Step 3 — place the block or paragraph

- **Block:** go to **Structure → Block layout** (`/admin/structure/block`) and
  place the **Location Signpost** block in the region where visitors should find
  it.
- **Paragraph:** add the module's paragraph type to a paragraphs field on the
  content where you want the lookup to appear inline.

## Data handling

Every lookup sends the visitor's **address or postcode to external APIs** (OS
Places and postcodes.io). That is location data and counts as personal data, so
disclose the third-party lookups in your site's privacy policy and keep all calls
over HTTPS.
