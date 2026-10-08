# Configuration

AI Vocabulary has one settings form and two permissions. The AI provider that
does the actual work is configured in the **AI** module — AI Vocabulary just picks
a default from what the AI module offers.

## Settings form

1. Log in as a user with **Administer AI vocabulary**
   (`administer ai vocabulary`) — a restricted permission.
2. Go to **Configuration → AI → AI Vocabulary**, or navigate to
   `/admin/config/ai/ai-vocabulary`.
3. Choose the **default AI provider** used for generation and set the
   **generation defaults** the form exposes (for example how many terms or how
   deep the hierarchy).
4. Save.

## Permissions

Set these under **People → Permissions**:

- **`generate ai vocabulary`** — lets a user open the generate form and create
  vocabularies. Because a generated vocabulary is written straight into taxonomy,
  treat this as a content‑structural, trusted‑editor permission.
- **`administer ai vocabulary`** *(restricted)* — lets a user change the default
  provider and generation defaults. Keep this to administrators.

## How generation flows

When an editor submits the generate form, the module builds a prompt
(`PromptBuilder`), calls the AI provider (`AIService`), and imports the returned
structure into taxonomy (`TaxonomyImporter`), transliterating labels into clean
machine names. The vocabulary is created immediately, so **review the terms
after generation** — rename or prune anything the model got wrong before you rely
on it.

> **Cost:** each generation is a call to your AI provider and incurs that
> provider's per‑call cost.
