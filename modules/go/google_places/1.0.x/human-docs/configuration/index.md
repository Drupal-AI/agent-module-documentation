# Configuration

Google Places needs a Google API key to reach the Places API. The key is billed
against your Google account, so it is a secret: keep it out of plain configuration
and out of Git. This module does the right thing by storing credentials through
the **Key** module rather than in exported config.

## Get a Google Places API key

1. In the [Google Cloud console](https://console.cloud.google.com/), create or
   select a project.
2. Enable the **Places API** (and any related APIs you need, such as Places
   Photos).
3. Create an **API key** credential, and restrict it (by API and, where possible,
   by referrer or IP) to limit abuse if it leaks.

## Store the key as a secret

Keep the value in an environment variable rather than typing it into a form that
ends up in config. With DDEV:

```bash
ddev dotenv set .ddev/.env --google-places-api-key=YOUR_KEY_HERE
ddev restart
```

The flag `--google-places-api-key` becomes the environment variable
`GOOGLE_PLACES_API_KEY` inside the web container. Do not commit `.ddev/.env`.

Then create a **Key** entity that reads from that variable:

1. Go to **Configuration → System → Keys** (`/admin/config/system/keys`) and click
   **Add key**.
2. Give it a label, choose an **Authentication** key type, and pick the
   **Environment** key provider pointing at `GOOGLE_PLACES_API_KEY`.
3. Save the key.

## Select the key on the settings form

1. Go to **Configuration → Google Places → Settings**
   (`/admin/config/google_places/settings`).
2. Choose the Key you just created as the Google Places API key.
3. Save.

## A note on data flow and cost

Searches and detail lookups — which may include user-entered addresses or free
text — are sent to Google over HTTPS (outbound egress). Every call counts against
your Google quota and can incur cost, so guard the feature against abuse and avoid
unnecessary lookups. Remember, too, that persisting Places data to display it on
your site is against Google's Terms & Conditions; use it for temporary/context
purposes as the module intends.
