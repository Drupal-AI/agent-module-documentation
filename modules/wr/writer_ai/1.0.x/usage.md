<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Writer AI registers the Writer.com LLM platform as an AI-module provider.

---

Writer AI provides a Writer (writer.com) AI provider for the Drupal AI module — so Writer's enterprise LLM platform becomes available for chat and related AI operations wherever the AI module offers a provider choice, for organizations standardized on Writer.

The Writer API key is stored via the Key module (env-backed); requests send prompts to Writer (cost + egress). Depends on `ai` and `key`; supports Drupal 10 and 11.

---

- Add Writer as an AI provider.
- Use Writer's LLM platform.
- Provide chat operations.
- Register a provider plugin.
- Make Writer models selectable.
- Send prompts to Writer (cost/egress).
- Store the API key via Key (env-backed).
- Depend on `ai` and `key`.
- Support Drupal 10 and 11.
- Integrate with the AI provider abstraction.
- Serve Writer-standardized orgs.
- Configure models.
- Keep the key secure
- Select Writer
- Route AI calls to Writer.
- Complement other providers.
- Handle provider config.
- Integrate Writer.com
