# Configuration

Lionbridge Translation Provider has **no settings page of its own**. You configure
it by adding a **Lionbridge translator** (a "provider") inside TMGMT, then supply
your Lionbridge Content API credentials. This page covers both, plus how to keep
those credentials out of your configuration exports.

## Add the Lionbridge translator in TMGMT

1. Log in as a user who can administer TMGMT.
2. Go to **Configuration → Regional and language → Translation Management
   Translators** (`/admin/tmgmt/translators`).
3. Add a new translator and choose the **Lionbridge** (Content API) plugin.
4. Enter the credentials from your Lionbridge Translation Services account — the
   **username**, **password**, and **API access token** — along with any other
   connection settings the plugin asks for.
5. Save, then use the translator's connection check (if offered) to confirm
   Drupal can reach the Lionbridge service with the credentials you entered.

Once the translator exists, it becomes a choice when you create TMGMT jobs: send
content to it, track the job's status inside TMGMT, and review and accept the
returned translations there.

## Keep the credentials out of exported config — store them as secrets

The Content API username, password, and access token are **secrets**. Do not
hard-code them where they could be committed, and prefer keeping them out of
exported site configuration. On a DDEV site, store each value in an environment
variable and surface it through a **Key** entity:

1. Save the secret into DDEV's dotenv file (this example uses the access token):

   ```bash
   ddev dotenv set .ddev/.env --lionbridge-api-token=<value>
   ```

   The flag `--lionbridge-api-token` becomes the variable
   `LIONBRIDGE_API_TOKEN`. Never commit `.ddev/.env`.

2. Restart so DDEV loads it into the web container:

   ```bash
   ddev restart
   ```

3. Confirm the variable is present **without printing its value**:

   ```bash
   ddev exec 'test -n "$LIONBRIDGE_API_TOKEN"'
   ```

   Exit status `0` means it is set.

4. If the Key module isn't enabled, add it, then create a Key that reads the
   environment variable:

   ```bash
   ddev composer require drupal/key
   ddev drush en key -y
   ddev drush key:save lionbridge_api_token \
     --label='Lionbridge API Token' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"LIONBRIDGE_API_TOKEN","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

Repeat for the username and password if you want all three managed the same way,
then reference the Key(s) from the translator settings where the plugin supports
it. Where a Key isn't applicable, read the variable from `settings.php` via
`getenv('LIONBRIDGE_API_TOKEN')` rather than storing the literal secret.

## A note on data leaving your site

This is a real integration with an external vendor: when you send a translation
job, **your source content is transmitted to Lionbridge** for human translation.
Be deliberate about which content you route to it, keep in mind it involves a
commercial contract and a per-word cost, and remember the returned translations
flow back into TMGMT for review before you accept them.
