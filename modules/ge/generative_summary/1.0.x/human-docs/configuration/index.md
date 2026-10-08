# Configuration

Generative Summary has two layers of settings: a **global** configuration form
that sets defaults for the whole site, and **per‑field** settings that override
those defaults on individual fields. You'll always start with the global form,
because that's where the OpenAI API key lives.

## Store your OpenAI API key securely

The module authenticates to OpenAI with an API key. A key is a **secret** — treat
it like a password. Never paste it into code, and never commit it to version
control.

The safest pattern with DDEV is to keep the key in an environment variable rather
than typing it straight into a config field:

1. Save the value into DDEV's dotenv file (this is git‑ignored):

   ```bash
   ddev dotenv set .ddev/.env --openai-api-key=sk-your-real-key-here
   ddev restart
   ```

   The flag `--openai-api-key` becomes the environment variable
   `OPENAI_API_KEY` inside the web container.

2. Confirm it is present **without printing it**:

   ```bash
   ddev exec 'test -n "$OPENAI_API_KEY" && echo set'
   ```

If your build uses the **Key** module for secret storage, store the OpenAI key as
a Key entity backed by the environment provider and reference that, so the raw
value never lives in exported configuration. Only fall back to pasting the key
directly into the settings form if you have no secret‑storage option — and if you
do, remember the value may end up in configuration exports.

## Open the global settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Content authoring → Generative Summary**, or navigate
   directly to `/admin/config/content/generative_summary`.

## Global settings, field by field

- **OpenAI API key** — the credential the module uses to call OpenAI. Provide the
  key (or reference your stored secret) here. Without it, the Generate Summary
  button cannot produce anything.
- **Minimum / maximum summary length** — the site‑wide default bounds for how
  long a generated summary should be. These act as guardrails passed to the model
  so summaries don't come back too short or too long.
- **Maximum number of sentences** — a default cap on how many sentences the
  summary may contain. Useful when you want tight, teaser‑style summaries.
- **System prompt** — the instruction that frames the assistant's role (for
  example, "You are an editor writing concise, neutral summaries."). This sets the
  overall behaviour of the model.
- **User prompt** — the instruction that accompanies the field content itself
  (for example, "Summarise the following text."). The field content is sent along
  with this prompt.

Click **Save configuration** to store the global defaults.

## Per‑field overrides

The global values are just defaults. To turn the feature on for a specific field
and optionally customise it there:

1. Go to **Structure → Content types → *(your content type)* → Manage fields**.
2. Edit the text/summary field you want the button on.
3. On that field's settings page, enable **Generative Summary** and, if you want
   this field to behave differently from the global defaults, set its own minimum
   and maximum length, sentence limit, and system/user prompts.
4. Save the field.

A field that has Generative Summary enabled but no per‑field overrides simply uses
the global values. Once saved, the **Generate Summary** button appears next to
that field on the content editing form.

## A note on cost and privacy

Every click of the button is a live, billable call to OpenAI, and it sends the
field content out to OpenAI's servers. Restrict which roles can edit the enabled
fields so only trusted editors can trigger calls, and make sure sending that
content to a third party is acceptable for your site's content and any applicable
data‑protection obligations.
