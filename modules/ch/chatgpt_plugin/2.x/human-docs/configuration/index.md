# Configuration

Before the AI helpers will work, you must give the module your OpenAI credentials.
After enabling the module, a **ChatGPT API Settings** link appears in the admin
**Configuration** area — open it to configure the connection.

## ChatGPT API settings

The settings form is where you provide everything needed to make the API call:

- **API endpoint** — the OpenAI API endpoint the module calls. Leave the default
  unless you have a specific reason to change it.
- **Access token (API key)** — your OpenAI API key. Treat this as a secret; rather
  than pasting the raw key, prefer referencing it from an environment variable / Key
  entity as described in [Installation](../installation/index.md).
- **Model** — choose which OpenAI model to use: **GPT‑3.5**, **GPT‑4**, or
  **GPT‑4o mini**. Pick the one that balances quality and cost for your needs.

Save the form once these are set.

## What the module then adds

With valid settings in place, the three helpers become usable:

- **Content generator** — a link on the node **add/edit** page opens a popup where
  you search ChatGPT and copy the generated article into your new or edited content.
- **Content translator** — a **"Translate using ChatGPT"** action appears on the
  content **Translate** tab for each enabled language that has no translation yet.
  Note the translation is **flat text** — OpenAI won't return HTML or styling, so
  re‑apply formatting afterwards.
- **Content assistance tool** — an **OpenAI Content Assistance Tool** tab on the
  content admin page (`/admin/content`) offers extras such as generating images from
  text and extracting SEO keywords from content.

## Things to keep in mind

- **Cost:** every generation/translation call is billed by OpenAI — watch usage.
- **Data governance:** prompts and content you submit leave your site and go to
  OpenAI. Don't send anything confidential you're not comfortable sharing, and
  ensure generated content complies with OpenAI's terms and policies.
