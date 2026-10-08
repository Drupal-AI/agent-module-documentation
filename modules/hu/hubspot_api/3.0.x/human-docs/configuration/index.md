# Configuration

The whole job of HubSpot API is to hold your HubSpot **credential** and hand it
to the modules that use it. So configuration here is short but important — and
the most important part is *how* you store the secret.

## Open the settings form

Log in as a user with the **Administer site configuration** permission and open
the HubSpot API settings form (reachable from **Configuration**). This is the
form that consuming modules — for example HubSpot Client — refer to as "the
HubSpot API settings form."

On it you provide your HubSpot connection details:

- A **HubSpot private‑app token** (the recommended approach for most
  integrations), or
- **OAuth** application settings, if your integration authenticates that way.

## Get the credential right — this is CRM access

A HubSpot private‑app token or OAuth credential grants access to contact records
— names, email addresses, interaction history — which is personal data by any
definition. The scopes you grant decide how much of the CRM the site can touch.
Treat a site holding a broadly‑scoped HubSpot credential as holding a copy of the
CRM's access, and follow these rules:

- **Scope to the minimum.** In HubSpot, give the private app only the scopes your
  integration actually needs, rather than accepting a broad default set.
- **Never commit the token or export it in configuration.** Keep it out of
  version control and out of exported config `.yml` files.
- **Rotate it** if it is ever exposed, and when staff with access leave.

## Store the secret in an environment variable (recommended)

Rather than pasting the token into a form field where it may end up in the
database and in config exports, store it in an environment variable and reference
it from a Key entity.

With DDEV, save the value into the container's environment:

```bash
ddev dotenv set .ddev/.env --hubspot-api-key=<your-token>
ddev restart
```

(The flag `--hubspot-api-key` becomes the variable `HUBSPOT_API_KEY`. Keep
`.ddev/.env` out of version control.)

Then, if the **Key** module is available, create a Key backed by that
environment variable and point the HubSpot credential at the Key instead of
storing the raw token:

```bash
ddev composer require drupal/key
ddev drush en key -y
ddev drush key:save hubspot_api_key --label='HubSpot API Key' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"HUBSPOT_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

## Data leaves the site — cover it in your privacy notice

Integrations built on this module usually push personal data (such as form
submissions) *out* to HubSpot, a US‑headquartered processor. On an EU‑facing
site that transfer needs the usual lawful basis and disclosure. Make sure your
privacy notice reflects that contact data is sent to HubSpot — that belongs in
the privacy policy, not buried in an integration ticket.

## Save

Save the form. The credential is now available to any module that builds on
HubSpot API's client service.
