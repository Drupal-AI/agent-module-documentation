# Configuration

Brandfolder is configured from its settings form at the
`brandfolder.brandfolder_settings_form` route (under **Configuration**). This is
where you connect Drupal to your Brandfolder account by entering the API
key/token and choosing the connection details for the library you want to use.

## Handling the API key as a secret

The Brandfolder API key is a credential. Do not paste it into exported
configuration or commit it to code, where it would end up in version control.
Keep it in an environment variable, and reference it through a Key entity where
the module allows selecting one.

1. **Store the value in an environment variable.** With DDEV, save it into the
   project's dotenv file (which stays out of version control):

   ```bash
   ddev dotenv set .ddev/.env --brandfolder-api-key='<your-api-key>'
   ddev restart
   ```

   The flag `--brandfolder-api-key` becomes the variable `BRANDFOLDER_API_KEY`
   inside the web container. Confirm it is present without printing it:

   ```bash
   ddev exec 'test -n "$BRANDFOLDER_API_KEY"'   # exit status 0 means it is set
   ```

2. **Reference the variable.** If you have the Key module installed, create a Key
   entity backed by the environment variable and select it in the settings form:

   ```bash
   ddev drush key:save brandfolder_api_key \
     --label='Brandfolder API Key' --key-type=authentication \
     --key-provider=env \
     --key-provider-settings='{"env_variable":"BRANDFOLDER_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

   If the settings form only accepts the key as plain text, at minimum keep it out
   of any configuration you export and commit; read it from `getenv('BRANDFOLDER_API_KEY')`
   where you can.

## Connect and verify

Once the credential is in place, save the settings form and confirm that Drupal
can reach your Brandfolder library — editors should be able to browse assets. If
the connection fails, re-check that the environment variable is set in the web
container and that the server has outbound HTTPS access to the Brandfolder API.
