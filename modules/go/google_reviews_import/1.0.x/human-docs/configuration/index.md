# Configuration

Google Reviews Import needs Google API credentials to fetch your reviews. Those
credentials are a secret, and the module stores them through the **Key** module
rather than in plain config — keep the raw value out of Git.

## Get your Google credentials

Set up access to the Google API that serves reviews for the business locations you
own (via the Google Cloud console / Business Profile APIs), and obtain the API key
or credentials the module expects.

## Store the credentials as a secret

Keep the value in an environment variable rather than typing it into a form that
ends up in config. With DDEV:

```bash
ddev dotenv set .ddev/.env --google-reviews-api-key=YOUR_KEY_HERE
ddev restart
```

The flag `--google-reviews-api-key` becomes the environment variable
`GOOGLE_REVIEWS_API_KEY` inside the web container. Do not commit `.ddev/.env`.

Then create a **Key** entity that reads from that variable at **Configuration →
System → Keys** (`/admin/config/system/keys` → **Add key**), choosing the
**Environment** key provider pointing at `GOOGLE_REVIEWS_API_KEY`.

## Configure the module

1. Go to **Configuration → Web services → Google Reviews Import**
   (`/admin/config/services/google_reviews_import_settings`).
2. Select the Key holding your credentials and set any location details the form
   asks for.
3. Save.

## Import and manage reviews

Run the migration to pull the reviews in (the module builds on Migrate Tools, so
you can also trigger it with `drush migrate:import`). Imported reviews appear at
**Content → Google reviews** (`/admin/content/google-review`), where the review
CRUD permissions this module provides — *administer / view / create / edit /
delete google_review* — control who can manage them.

## A note on data flow

Import requests go out to Google over HTTPS (outbound egress). No secret is stored
in plain configuration when you use the Key module as described above.
