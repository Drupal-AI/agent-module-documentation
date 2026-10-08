# Configuration

Configuration is a short sequence: authenticate with Make, pick the list to
subscribe people to, decide which fields the form collects, then place the signup
block on your site.

## Open the settings form

Go to **Configuration → Web services → Make** (`/admin/config/services/make`).
You'll need the **Administer site configuration** permission.

## Get your credentials from Make

Log in to your Make (make.as) account and open the **Integrations & API** page to
find your **User ID** and **API Key**. Keep the API Key private — treat it like a
password.

## Enter and authenticate

Back on the Drupal settings form:

1. Enter your **User ID**.
2. Enter your **API Key**.
3. **Save** — the module authenticates against Make using these credentials
   before it can do anything else. If the credentials are wrong, saving won't let
   you proceed to list selection.

### Keep the API Key out of your codebase

The API Key is a secret. Never hard-code it or commit it to version control.
Store the value in an environment variable and feed it in from there. With DDEV:

```bash
ddev dotenv set .ddev/.env --make-api-key=YOUR_KEY_HERE
ddev restart
```

That makes the value available as `MAKE_API_KEY` inside the container (keep
`.ddev/.env` out of version control). You can then reference it from
`settings.php` via `getenv('MAKE_API_KEY')` and set the module's key from
settings, so the secret never lives in exported configuration.

## Choose a subscriber list

Once authentication succeeds and you have saved, the form lets you **select the
subscriber list** you want new signups to join. This is fetched live from your
Make account, so you pick from the lists that already exist there.

## Choose which fields the form collects

You can optionally enable which **fields appear on the subscription form** — for
example just an email address, or additional details you collect in Make. Only
the fields you enable are shown to visitors.

## Place the signup block

The form is added to your site as a block:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find and place the **Make Signup Block** in the region where you want the
   signup form to appear (a sidebar or footer is common).
3. Configure the block's visibility as you would any block, and save.

Visitors who submit the form are subscribed to the Make list you selected.

## A note on the roadmap

Per-block list selection and per-block custom fields are planned but not yet
available, so today the list and field choices are configured once, site-wide, on
the settings form above.
