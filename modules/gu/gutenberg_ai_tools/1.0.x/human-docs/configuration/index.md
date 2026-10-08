# Configuration

Setting up Gutenberg AI Tools has three parts: configure the AI provider (in the AI
module), point this module at a provider and model, and enable the AI Block for the
content types where you want it.

## 1. Configure the AI provider and its key

The actual credentials and provider settings live in Drupal's **AI** module, not
here. Enable the provider submodule for your service (OpenAI, Azure OpenAI, Google
Gemini, …) and configure its API key following the AI module's documentation.

Following this project's conventions, store the provider API key in an environment
variable surfaced through a **Key** entity, rather than pasting the raw key into a
form. For example, with DDEV and an OpenAI key:

```bash
ddev dotenv set .ddev/.env --openai-api-key=YOUR_KEY_HERE
ddev restart
```

(Never commit `.ddev/.env`.) Then reference it through a Key entity in the AI
provider configuration. This keeps the secret out of version control.

## 2. Select the provider and model

1. Go to the **Gutenberg AI settings** form at
   **`/admin/config/openai/gutenberg-ai-settings`**.
2. Select the **AI provider** you configured in step 1.
3. Select the **model** to use for the AI Block's prompts.
4. Save.

## 3. Allow the AI Block on a content type

The AI Block is a custom Gutenberg block, so it must be permitted on the content
types that use the Gutenberg editor:

1. Go to **Structure → Content types**, and choose the content type (Page, Article,
   etc.).
2. In the left sidebar menu, click **Gutenberg Experience**.
3. Click **Enable Gutenberg experience** if it isn't already on.
4. Scroll to **Allowed Custom Gutenberg blocks** and tick **AI Block**.
5. Save.

## Using the block

In the Gutenberg editor, add the **AI Block**, type your question in the "Start
typing your question" field, and click **Ask AI**. The answer renders in the block
below after a moment. The right‑hand panel offers a **Block title** field for the
generated content and an **AI answer** field you can edit to refine the response.

## Cost and data‑egress reminders

- **Every "Ask AI" is a billable LLM call.** Costs scale with how often editors use
  the block and how large the prompts and responses are. Watch your provider usage.
- **Prompt text leaves your site.** The question (and any context sent with it) goes
  to the third‑party AI provider. Make sure that is acceptable for the content your
  editors will paste in, and disclose it internally as needed.
