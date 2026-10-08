# Configuration

Pipedrive needs one essential piece of information to work: your **Pipedrive API
token**. Because that token grants access to your CRM data, the important part of
configuration is storing it *securely* rather than as plain text in Drupal's
configuration.

## Get your API token

In Pipedrive, go to **Settings → Personal preferences → API** and copy your personal
API token. (You can regenerate it there if it is ever exposed.)

## Store the token as a secret (recommended)

Never hard-code the token or commit it to version control. Store it in an environment
variable and reference it through Drupal's **Key** module.

**1. Save the value as an environment variable.** With DDEV, use the built-in dotenv
command (the flag name becomes the variable name):

```bash
ddev dotenv set .ddev/.env --pipedrive-api-token=<your-token>
ddev restart
```

Keep `.ddev/.env` out of version control. After the restart, confirm the variable is
present in the container **without printing its value**:

```bash
ddev exec 'test -n "$PIPEDRIVE_API_TOKEN"' && echo "set"
```

**2. Install the Key module if it is not already enabled:**

```bash
ddev composer require drupal/key
ddev drush en key -y
```

**3. Create a Key entity backed by the environment variable:**

```bash
ddev drush key:save pipedrive_api_token \
  --label='Pipedrive API Token' \
  --key-type=authentication \
  --key-provider=env \
  --key-provider-settings='{"env_variable":"PIPEDRIVE_API_TOKEN","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

Then point the module's connection settings at this Key rather than typing the token
into a plain configuration field. If your version of the module offers only a plain
text token field, at minimum keep the token out of exported configuration and
committed files, and consider overriding it from `settings.php` via
`getenv('PIPEDRIVE_API_TOKEN')`.

## Privacy and data-sharing

Everything you sync — contact names, emails, phone numbers, lead details — is
**personal data** that leaves your site and is processed by Pipedrive, a third-party
service. Before syncing:

- Make sure you have a lawful basis and, where required, the person's **consent**.
- **Disclose** the sharing with Pipedrive in your privacy policy (GDPR, CCPA, and
  similar).
- Send only the fields you actually need in the CRM.

## Save

Save the connection settings once the token (or Key reference) is in place, then run
a test create against Pipedrive as described in
[Installation → Verify it worked](../installation/index.md#verify-it-worked).
