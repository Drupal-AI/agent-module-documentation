# Configuration

Getting Crux working is a short sequence of steps rather than a single form: enable
the `@`-mention filter, connect an AI provider, configure Crux's own settings, and
set up the queue that processes mentions. Do them in this order.

## Step 1 — Allow user mentions in a text format

Crux is triggered by CKEditor mentions of a user, so a text format has to allow them.

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Edit the text format your content and comments use, and enable the **CKEditor
   Mentions** filter configured to allow **user** mentions.
3. Make sure the content where you want to use Crux has **comments enabled** —
   mentions in content rely on the comment thread.

## Step 2 — Set up your AI provider

Crux uses the **AI** module to talk to a provider such as OpenAI.

1. Obtain an API key from your AI provider.
2. Store it securely rather than in plain config. On DDEV, save it as an environment
   variable and restart:

   ```bash
   ddev dotenv set .ddev/.env --openai-api-key=<value>
   ddev restart
   ```

   The flag `--openai-api-key` becomes the variable `OPENAI_API_KEY`. **Never commit
   `.ddev/.env`.** Confirm it's set without printing it:

   ```bash
   ddev exec 'test -n "$OPENAI_API_KEY"'   # exit status 0 means it is set
   ```

   Then create a **Key** entity backed by that variable (enable the Key module first
   if needed with `ddev drush en key -y`):

   ```bash
   ddev drush key:save openai_api_key --label='OpenAI API Key' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"OPENAI_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```
3. In the AI module's configuration, set up your provider using that key and choose a
   model.

> **Egress and cost caveats:** Crux makes outbound calls to your AI provider, so make
> sure your environment allows that outbound (egress) connection. And because **every
> mention triggers an LLM call**, keep the permission to comment/mention tight and
> apply rate limiting where you can — this directly controls your API spend.

## Step 3 — Configure Crux

1. Go to **Configuration → AI → Crux** (`/admin/config/ai/crux`).
2. Configure the bot's settings there so it knows which bot user is summoned by a
   mention and how to respond (drawing on the AI provider you set up in Step 2).
3. Save.

## Step 4 — Process the mention queue

Crux doesn't reply instantly — mentions are queued and handled on a schedule, which
keeps live posting fast. Run the queue regularly:

```bash
drush queue-run crux_mentions_response
```

Set this up as a scheduled job (for example via cron) so mentions are answered
promptly.

## Verify

Mention the bot (e.g. `@crux`) in a comment or in content with comments enabled, then
run the queue. The bot should post an AI-generated reply — in threaded comments it
appears in the correct place in the conversation; in top-level content it appears as
a new comment.
