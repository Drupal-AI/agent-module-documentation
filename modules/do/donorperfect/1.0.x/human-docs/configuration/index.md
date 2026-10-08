# Configuration

All of DonorPerfect Base Module's setup happens on one settings page. Before you
begin, make sure you have a DonorPerfect account with XML API access enabled and
your API credentials to hand — preferably an **API key** from your DonorPerfect
representative rather than a username and password.

## Store your API credentials securely first

Your DonorPerfect credentials are secrets and should never be hard‑coded or
committed to version control. The recommended approach is to keep the value in an
environment variable and reference it through Drupal, rather than typing it into a
form that is saved to the database in plain text.

With DDEV, save the value into DDEV's dotenv file and restart so it is available
in the container:

```bash
ddev dotenv set .ddev/.env --donorperfect-api-key=<your-api-key>
ddev restart
```

That makes the value available as the environment variable
`DONORPERFECT_API_KEY` inside the web container. **Never commit `.ddev/.env`.**
Confirm the variable is present *without printing its value*:

```bash
ddev exec 'test -n "$DONORPERFECT_API_KEY"'   # exit status 0 means it is set
```

If you want to manage the secret as a first‑class Drupal object, install the
**Key** module and create a Key backed by that environment variable:

```bash
ddev composer require drupal/key
ddev drush en key -y
ddev drush key:save donorperfect_api_key \
  --label='DonorPerfect API Key' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"DONORPERFECT_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

Then reference the environment variable (or the Key) when supplying the credential
on the settings page below, rather than pasting the raw secret.

## Open the settings form

1. Log in as a user with the **DonorPerfect admin** (`donorperfect admin`)
   permission (or an administrator).
2. Go to **`/admin/donorperfect/settings`**.

## Enter your API credentials

At the top of the form, supply your DonorPerfect API credentials — either a
**username and password**, or (preferred) an **API key**. Enter the value sourced
from your environment variable / Key rather than a raw pasted secret where your
workflow allows it, then click **Save configuration** at the bottom of the form to
store the credentials.

## Populate the DonorPerfect cache

After saving valid credentials, use the button in the **DonorPerfect Cache**
dropdown on the settings page to populate the local metadata cache. This fetches
metadata about the DonorPerfect fields (the same information you would find in
DonorPerfect's Screen Designer and Code Maintenance) and stores it in the Drupal
database. The actual donor data is *not* copied locally — only this field
metadata is cached.

## Choose which fields appear on your Drupal entities

Also on the settings page, use the **Drupal Entity Settings** fieldset to select
which DonorPerfect fields should be included on the Drupal entities. The fields you
select here are the ones that will be available when you create Views or load the
entities in custom modules, so pick the fields your site actually needs.

## Configure permissions

On **People → Permissions**, grant permissions as appropriate:

- **DonorPerfect admin** (`donorperfect admin`) — for the trusted users who manage
  this settings page and the integration.
- **Use DonorPerfect** / **DonorPerfect user** (`donorperfect user`) — required for
  a Drupal user to use the Name form element's AJAX search of DonorPerfect
  described in the overview.

## After configuration — a privacy reminder

Once fields are exposed, you can build Views to display DonorPerfect data in many
ways. Because this data includes donor personal information fetched from an
external service, **set proper access restrictions on any View you build** — never
expose private donor data through a publicly accessible View — and keep the API
credentials env‑backed as described above.
