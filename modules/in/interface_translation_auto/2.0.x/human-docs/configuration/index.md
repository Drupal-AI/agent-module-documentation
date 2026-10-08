# Configuration

Interface Translation Auto needs one thing before it can work — an API key for
DeepL or OpenAI — and is then driven from the Languages page.

## Step 1 — Add your API key

1. Log in as a user who can administer the module's settings (an administrator by
   default).
2. Go to **Configuration → Regional and language → Interface Translation Auto**, or
   navigate directly to `/admin/config/regional/interface-translation-auto`.
3. Enter your **DeepL** or **OpenAI** API key and save.

## Step 2 — Run the translation batch

1. Go to the **Languages** page at **Configuration → Regional and language →
   Languages** (`/admin/config/regional/language`).
2. Click the **"Translate untranslated strings"** link.
3. The batch process starts, sending every untranslated English interface string to
   the translation API and storing the result for the selected language. Wait for
   the batch to finish — on a large site this can take a while.

When it completes, the previously missing UI strings will be translated. Because
these are machine translations, plan a review pass: you can edit any of them from
Drupal's usual interface‑translation UI.

## Storing the API key securely

The API key authenticates to a paid external service, so protect it:

- Never commit it to version control or paste it into exported configuration.
- Prefer an **environment variable**. In **DDEV**, store it with
  `ddev dotenv set .ddev/.env --deepl-api-key=<value>` (or an equivalent name for
  OpenAI; keep `.ddev/.env` out of version control) and `ddev restart` so DDEV
  loads it, then reference it when populating the setting.
- Keep all traffic on HTTPS, and rotate the key with the provider if it is ever
  exposed.

## Verify it worked

Switch the site (or a page) to the target language and confirm that interface
strings which were previously in English now appear translated. Spot‑check a few
for quality and correct any that need it.
