# Configuration

Configuration happens inside TMGMT: you create a **provider** backed by the
LanguageWire plugin, give it your LanguageWire credentials, and then translate
content through the normal TMGMT flow.

## Create the LanguageWire provider

1. Log in as a user with permission to administer TMGMT (an administrator by
   default).
2. Go to **Translation → Providers** (`/admin/tmgmt/translators`).
3. Choose **Add provider** (or **Create provider**).
4. Give it a label, and select **LanguageWire** as the translator plugin.
5. Enter the connection details supplied by LanguageWire — the **API
   credentials** and any endpoint/account settings they provide.
6. **Save** the provider.

## Store the API credentials safely

LanguageWire credentials are secrets. Never hard‑code them or commit them to
version control (including exported configuration).

The recommended pattern on this project is to keep the value in an environment
variable rather than typing it straight into config that might be exported:

1. Save the secret into DDEV's dotenv file (this example uses a made‑up flag name;
   name it to match the credential you are storing):

   ```bash
   ddev dotenv set .ddev/.env --languagewire-api-key=<value>
   ddev restart
   ```

   The flag `--languagewire-api-key` becomes the environment variable
   `LANGUAGEWIRE_API_KEY`. Keep `.ddev/.env` **out of version control**.

2. Confirm the variable is present in the container **without printing its value**:

   ```bash
   ddev exec 'test -n "$LANGUAGEWIRE_API_KEY"'   # exit status 0 means it is set
   ```

3. Where the integration supports a **Key** entity, create one backed by the
   environment provider and point the provider at it, so the secret is never
   stored in plain config. If the provider form only accepts the value directly,
   make sure that configuration is **not exported and committed** with the secret
   in it.

Because using this provider sends the content to be translated **out to
LanguageWire**, confirm that external egress is acceptable for the content you
plan to translate — particularly anything personal or otherwise sensitive — and
that the connection is over **HTTPS**.

## Translate content

Once the provider exists:

1. Go to **Translation → Sources** and select the content (nodes, etc.) you want
   translated.
2. **Add them to the basket** (the TMGMT cart).
3. Open the basket and **check out** — choosing your **LanguageWire** provider and
   the target language(s).
4. LanguageWire processes the job; **Ultimate Cron** handles the background
   processing, so make sure cron is running. Returned translations appear back in
   **Translation → Jobs** for review and acceptance.

## Verify

Create a small test job, check it out to LanguageWire, let cron run, and confirm
the translated content comes back into the corresponding job in **Translation →
Jobs**.
