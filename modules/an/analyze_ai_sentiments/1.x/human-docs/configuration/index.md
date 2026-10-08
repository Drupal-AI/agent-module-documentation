# Configuration

This module has no settings form of its own. Setup is the standard Analyze-plus-AI flow:
configure an AI provider, then enable the analyzer for the content types you want.

## 1. Configure a chat AI provider

Go to **Configuration → AI → Providers** (`/admin/config/ai/providers`) and make sure a
chat provider/model is configured. The sentiment analyzer uses this provider to assess
content.

Keep the provider's **API key out of plain configuration** — store it as a credential
(for example via the Key module, backed by an environment variable) rather than pasting
it into settings that get exported.

## 2. Enable the analyzer per content type

Go to **Configuration → Content → Analyze settings**
(`/admin/config/content/analyze-settings`) and turn on the AI Sentiments analyzer for
each content type you want assessed. Leave it off elsewhere to avoid needless API calls.

## Before you turn it on — privacy and cost

- **Content leaves your infrastructure.** The text you analyze is sent to the external
  AI provider. Only enable it on content that is acceptable to share off-site, and apply
  your own governance for confidential material.
- **Watch API cost.** Each analysis is a provider API call. Enable the analyzer
  deliberately, on the content types where sentiment insight is actually useful.
- **The output is advisory.** Treat the sentiment reading as guidance for editors, not a
  definitive judgment. Test on non-production content before rolling it out widely.
