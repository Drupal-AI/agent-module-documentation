# Configuration

All of DaData Integration's setup happens on one settings form: you provide your
API key, then tell the module which form fields should get suggestions and what
kind.

## Open the settings form

1. Log in as a user who can administer the site's configuration.
2. Go to **Configuration → Web services → DaData Integration**
   (`/admin/config/services/dadata`).

## Enter your credentials

- **API Key** *(required)* — the key from your [dadata.ru](https://dadata.ru/)
  account. It authenticates every suggestion request. **Treat it as a secret:**
  keep it out of version control, and where your workflow allows, supply it from an
  environment variable rather than a committed config export (for DDEV,
  `ddev dotenv set .ddev/.env …` and reference the variable).
- **Base API URL** *(optional)* — override the default DaData endpoint if you use a
  self‑hosted gateway or a DaData mirror. Leave it as the default otherwise.

## Attach suggestions to your fields

For each field you want to enhance, add an entry identifying the field by its HTML
`id` (for example `edit-city`) and choose:

- **Suggestion type** — one of:
  - **address** — street addresses, with the granularity control below.
  - **fio** — full personal names (autofill).
  - **party** — companies / organizations (quick lookup).
  - **email** — valid email suggestions.
- **Granularity (bound)** — *addresses only.* Restrict suggestions to a level:
  country, region, city, settlement, street, or house. This lets one field suggest
  just cities while another suggests full street addresses.

You can configure **multiple fields**, each with its own type, and it works with
any Drupal text field including Webform elements.

Save the configuration. From then on, the configured fields show DaData
suggestions as users type.

## Privacy and data flow

DaData is an **external service**. As users type, the field values — including
partial addresses and other personal data — are **sent to DaData** to generate
suggestions. Disclose these third‑party lookups in your privacy policy, and only
enhance the fields that genuinely benefit from suggestions.
