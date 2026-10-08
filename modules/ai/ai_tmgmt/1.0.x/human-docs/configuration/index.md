# Configuration

AI Translator does not add a settings page of its own. You configure it as a
**translator inside TMGMT**, and the AI provider, model, and credentials come
from the **AI** module. So configuration is really two things: making sure the
AI module has a working provider, and adding an AI-backed translator in TMGMT.

## Step 1 — configure the AI provider

If you have not already:

1. Under **Configuration → AI** (`/admin/config/ai`), enable and configure an AI
   provider (a hosted provider such as OpenAI or Anthropic, or a locally hosted
   model through **Ollama**).
2. Store the provider API key as a secret — a **Key** entity backed by an
   environment variable is the recommended pattern; never paste the key into
   plain configuration.

For unpublished or confidential content, prefer a **local Ollama model**: it
keeps the text inside your own infrastructure while the TMGMT workflow stays
identical.

## Step 2 — add the AI translator in TMGMT

1. Log in as a user who can administer TMGMT.
2. Go to **Administration → Translation → Providers** — the TMGMT translator
   collection at `/admin/tmgmt/translators`.
3. Add a translator and choose the **AI**-backed plugin this module provides.
4. Select the AI provider/model it should use, and save.

## Step 3 — use it, but keep review on

Create translation jobs the normal TMGMT way and pick the AI translator as the
provider for the job. Keep these recommendations in mind:

- **Treat output as a draft.** LLM translation is a first draft; TMGMT's
  review/acceptance step is where quality is enforced. **Do not enable
  auto-accept** — route the output through a human review.
- **Watch the cost.** Hosted providers bill per token, so the size of a job is a
  direct cost. A local model avoids per-token billing.
- **Evaluate per language pair.** Quality varies sharply between language pairs.
  Test on the pairs you actually need before committing to them, rather than
  judging from a single demo.
