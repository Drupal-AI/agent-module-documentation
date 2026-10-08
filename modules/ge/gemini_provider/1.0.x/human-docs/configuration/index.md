# Configuration

Configuration is short: point the provider at the Key entity that holds your API
key, and optionally set the content-safety thresholds. You need the AI module's
**Administer AI providers** permission.

## Open the settings form

Go to **Configuration → AI → Providers → Gemini**
(`/admin/config/ai/providers/gemini`). You reach the same page from the AI
providers listing.

## Select the API key

The **API Key** field is a **Key selector**, not a place to paste the secret. It
lists the Key entities defined on your site; choose the one you created for Gemini
(for example `gemini_api_key`). At request time the AI framework resolves that Key
to the real secret and authenticates with Google — the raw key is never stored in
this module's configuration.

If the dropdown is empty, you haven't created a Key yet — go back to
[Installation](../installation/index.md) and create one (ideally an
*Authentication* key using the **Environment** provider so the secret lives in an
environment variable, never in the database or in exported config).

The provider only becomes usable once this field is set. Some parts of the UI —
such as listing the available Gemini models — make a live call to Google's API and
therefore need a valid key to work.

## Safety settings

Google Gemini can filter generated content by category. The form lets you set a
blocking threshold for each **harm category**:

- **Harassment**
- **Hate speech**
- **Sexually explicit**
- **Dangerous content**

For each category you can choose how aggressively to block:

- **Block low and above** — the strictest; blocks anything from low probability up.
- **Block medium and above**
- **Block only high** — the most permissive blocking option.
- **Block none** — do not block on this category.
- **Off** — turn the safety check off for this category.

Leaving a category unset means it is simply not configured, and Gemini's own
defaults apply. These thresholds are applied to every generative request the
provider makes.

## Save

Click **Save configuration**. Gemini is now available to the AI module. Rather than
hard-coding Gemini everywhere, the recommended approach is to set Gemini (and a
specific model) as the default provider for the operations you want in the AI
module's own settings — that way the abstraction picks the right provider for each
task, which is the whole point of the AI module.

## A quick sanity check

After saving, revisit the form or the AI module's provider/model listings. If the
available Gemini models load without error, your Key is resolving correctly and the
provider can reach Google's API. If listing models fails, re-check that the
environment variable is set in the container and that the Key points at the right
variable name.
