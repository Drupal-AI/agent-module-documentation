# Configuration

Getting Node AI Assistant working takes three steps: configure an AI provider
(through the AI module), grant the permission to the right roles, and — on the
module's own settings form — choose which fields are sent to the AI and set up
suggestion chips. Before that, a note on what leaves your site.

## Understand the data flow first

When an editor uses the assistant, the node's field data **and their prompts are
sent to the external AI provider** you configure. That data can be unpublished or
sensitive. Before enabling this for real content:

- Confirm it is acceptable to send that content to your provider, and **disclose**
  it per your privacy/data policy.
- Keep the provider **API key as a secret** — configure it through the Key module
  (see below), never hard-coded or committed.
- Be aware of **per-call cost** — each question is an AI API call.
- Use the field-selection settings (below) to **limit what is sent** to only the
  fields editors actually need to query.

## 1. Configure an AI provider

1. Go to **Administration → Configuration → AI → Providers**.
2. Configure at least one provider (for example OpenAI, Anthropic Claude, Azure
   OpenAI, or Google Gemini) with a valid **API key**, supplied via the **Key**
   module.
3. Set your provider as the **default provider for the "Chat" operation type**,
   which is what the assistant uses.

**Storing the API key securely with DDEV and Key.** Rather than pasting the key
into the database, hold it in an environment variable and reference it from a Key
entity:

```bash
ddev dotenv set .ddev/.env --openai-api-key=<your-api-key>
ddev restart
ddev exec 'test -n "$OPENAI_API_KEY"'   # exit status 0 means it is set
```

Then create the Key (install the Key module first with
`ddev composer require drupal/key && ddev drush en key -y` if it isn't already
enabled):

```bash
ddev drush key:save openai_api_key \
  --label='OpenAI API Key' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"OPENAI_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

Select that Key when configuring the provider in the AI module.

## 2. Grant the permission

Go to **People → Permissions** (`/admin/people/permissions`) and grant **Use node
AI assistant** (`use node ai assistant`) to the roles that should see the tab —
typically Content Editor and Moderator. Only users with this permission get the
AI Assistant tab.

## 3. The module settings form

Go to **Configuration → Content authoring → Node AI Assistant**
(`/admin/config/content/node-ai-assistant`). Here you control, per content type:

- **Which fields are sent to the AI.** Select the fields you want included in the
  conversation. Any field you **exclude** here will not be sent — so questions
  about excluded fields will go unanswered. Use this to keep sensitive fields out
  of the AI request and to trim cost.
- **Default chat snippets (suggestion chips).** Define your own ready-made prompt
  suggestions so editors can click a chip instead of typing a question from
  scratch.

Save the form.

## Try it

Open an **existing** node's edit form, click the **AI Assistant** tab in the
vertical tabs area, and either type a question or click a suggestion chip. The
assistant answers using only that node's field data (limited to the fields you
allowed), and never changes the node's content.
