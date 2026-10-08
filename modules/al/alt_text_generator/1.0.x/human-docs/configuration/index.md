# Configuration

Because Alt Text Generator calls an external AI vision model, setup has two parts:
connecting an AI provider with an API key, and deciding who is allowed to trigger
generation.

## 1. Connect an AI provider and API key

The module generates text by calling your site's configured AI provider using the
site's API key. Set up that provider (for example your OpenAI-compatible or other
vision-capable provider) and make sure it has a valid key.

**Store the key securely — never hard-code or commit it.** Keep the value in an
environment variable and reference it through a **Key** entity rather than pasting
it into a settings form. In this DDEV project the pattern is:

```bash
# store the secret in DDEV's dotenv (not committed) and reload
ddev dotenv set .ddev/.env --openai-api-key=<value>
ddev restart

# confirm it is present in the container without printing it
ddev exec 'test -n "$OPENAI_API_KEY"'   # exit status 0 means it is set

# create a Key entity that reads the environment variable
ddev drush key:save openai_api_key --label='OpenAI API Key' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"OPENAI_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

Then point your AI provider at that Key.

## 2. Open the module's settings

1. Log in as a user with the **Administer site configuration** permission.
2. Open the Alt Text Generator settings under **Configuration**. If you don't see
   a direct link, find the module on the **Extend** page (`/admin/modules`) and use
   its **Configure** / settings link.
3. Choose the AI provider/model the module should use for generating alt text and
   save.

## 3. Control who can generate

The generate endpoint is available to any role with the core **access content**
permission — a broad audience. Since each generation call incurs cost at your AI
provider:

- Review which roles have **access content** and restrict it if generation should
  be limited to trusted editors.
- **Monitor your provider's usage and spend**, especially after first enabling the
  feature.

## Using it

Once configured, editors working with an image field can trigger generation to
produce alt text for an image, review the suggestion, and accept it into the field.
The module supports passing a language so descriptions can be generated per
language.
