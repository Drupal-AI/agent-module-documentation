# Configuration

Setting the module up has three parts: enter the Google API key on the global
form, place the widget on a string field, and grant the permission that lets
editors use the lookup.

## 1. Global settings — API key and region bias

1. Log in as a user with the **Administer geocoder autocomplete** permission.
2. Go to **Configuration → System → Geocoder Autocomplete**
   (`/admin/config/system/geocoder_autocomplete`).

The form has two fields:

- **API key** — your Google Cloud API key. It must have the **Geocoding API**
  enabled and billing configured. This key is sent server‑side on every lookup and
  is never exposed in page markup.
- **Region code bias** *(optional)* — a two‑letter ISO region code (for example
  `us`, `gb`, `fr`) that biases results toward a country. Leave it blank for no
  bias.

Save the form. You can also set these from the command line:

```bash
drush config:set geocoder_autocomplete.settings api_key '<google-api-key>' -y
drush config:set geocoder_autocomplete.settings region_code_bias 'us' -y
```

## 2. Put the widget on a field

The widget is chosen per field, not on the global form. For any **string** (plain
text) field:

1. Go to the bundle's **Manage form display** tab — for example
   **Structure → Content types → [type] → Manage form display**.
2. Find your string field and change its **Widget** to **Geocoder Autocomplete**.
3. Click the gear/cog to adjust the widget settings if you wish:
   - **Size** — the width of the text field (default `60`).
   - **Placeholder** — the greyed‑out prompt text (default *"Digit a place"* —
     you will likely want to change this to something like *"Enter an address"*).
4. Click **Update**, then **Save**.

Editors will now get Google address suggestions as they type in that field, and
the selected formatted address is stored in the field.

## 3. Grant the permissions

On **People → Permissions** (`/admin/people/permissions`) the module adds two
permissions:

- **Access geocoder autocomplete** — this both controls access to the lookup
  endpoint **and** decides whether the widget wires up its autocomplete behavior.
  Grant it to the roles that edit address fields. A user without it sees the field
  as a plain text box with no suggestions. Because the lookup route requires this
  permission, anonymous users cannot hit the endpoint and burn through your Google
  API quota unless you grant it to them.
- **Administer geocoder autocomplete** — access to the global settings form (which
  holds the API key). Keep this restricted to trusted administrators.

## Verify it worked

Open a content form that contains the field, start typing an address, and confirm
suggestions appear. If nothing appears, check that the editing role has *Access
geocoder autocomplete*, that the API key is present, and that the Geocoding API and
billing are active in Google Cloud.
