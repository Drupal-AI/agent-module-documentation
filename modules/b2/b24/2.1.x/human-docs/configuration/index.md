# Configuration

## 1. Enter the Bitrix24 credentials

Open the credentials form (route `b24.credentials`) as a user with the module's
administration permission, and enter the details that let Drupal authenticate to your
Bitrix24 account — a **webhook URL** or **OAuth** credentials, depending on how you set
up the integration in Bitrix24.

### Keep the credentials secret

The webhook URL / OAuth secret grants access to your CRM. Do **not** commit it in
exported configuration. Supply it from the environment:

```bash
ddev dotenv set .ddev/.env --b24-webhook=<value>
ddev restart
```

(The flag becomes the variable `B24_WEBHOOK`. Never commit `.ddev/.env`.) Reference it
from Drupal via `getenv('B24_WEBHOOK')`, or a Key entity backed by the env provider.
Make sure the connection to Bitrix24 is over **HTTPS**.

## 2. Configure the submodules you enabled

Each submodule handles a different source of data. Once its parent integration exists
on the site, configure how records map into Bitrix24:

- **Commerce** (`b24_commerce`) — push orders as they are placed.
- **Contact** (`b24_contact`) — push core Contact form submissions.
- **User** (`b24_user`) — sync user account data.
- **UTM** (`b24_utm`) — attach captured UTM campaign parameters to the data sent.
- **Webform** (`b24_webform`) — push Webform submissions.

## Privacy

The data you send to Bitrix24 — names, email addresses, phone numbers, order details —
is personal data leaving your site for a third‑party CRM. Make sure your privacy notice
and consent handling cover that transfer, and only send the fields you actually need.
