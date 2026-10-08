# Configuration

To connect Drupal to your Planyo account, the module needs your Planyo **site details**
and an **API key**. Because the API key grants access to your Planyo account, the
important part of configuration is storing it securely rather than as plain text.

## Get your Planyo details

From your Planyo dashboard, note your **site ID** and generate/copy your **API key**
(Planyo → Settings → API). You will point the module at these values.

## Store the API key as a secret (recommended)

Never hard-code the API key or commit it to version control. Store it in an environment
variable and reference it through Drupal's **Key** module.

**1. Save the value as an environment variable.** With DDEV, use the built-in dotenv
command (the flag name becomes the variable name):

```bash
ddev dotenv set .ddev/.env --planyo-api-key=<your-key>
ddev restart
```

Keep `.ddev/.env` out of version control. After the restart, confirm the variable is
present in the container **without printing its value**:

```bash
ddev exec 'test -n "$PLANYO_API_KEY"' && echo "set"
```

**2. Install the Key module if it is not already enabled:**

```bash
ddev composer require drupal/key
ddev drush en key -y
```

**3. Create a Key entity backed by the environment variable:**

```bash
ddev drush key:save planyo_api_key \
  --label='Planyo API Key' \
  --key-type=authentication \
  --key-provider=env \
  --key-provider-settings='{"env_variable":"PLANYO_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

Then reference this Key from the module's settings rather than typing the key into a
plain configuration field. If the module offers only a plain text field, at minimum
keep the value out of exported configuration and committed files, and consider
overriding it from `settings.php` via `getenv('PLANYO_API_KEY')`.

## Configure the Planyo connection

In the module's settings, enter your Planyo **site ID** and point it at your API key
(the Key entity above). Save the settings so the widget knows which Planyo site to
display.

## Privacy and third-party processing

Bookings and customer details entered through the widget are processed by **Planyo**, a
third-party service, and any payments run on Planyo's side. Accordingly:

- Serve the reservation pages over **HTTPS**.
- **Disclose** the data sharing with Planyo in your privacy policy (GDPR and similar),
  and obtain consent where required.

## Save

Save the configuration, then confirm the widget renders and shows your Planyo site's
availability as described in
[Installation → Verify it worked](../installation/index.md#verify-it-worked).
