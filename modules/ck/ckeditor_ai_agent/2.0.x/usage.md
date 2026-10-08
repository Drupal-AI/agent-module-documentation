<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor AI Agent puts AI assistance inside the editor: an editor asks for text to be written, rewritten or summarised, and the request goes through the site's configured AI provider and streams back into the document.

---

Putting generation where the writing happens is the difference between a feature editors use and one they forget. This module adds a CKEditor 5 plugin (`Plugin/CKEditor5Plugin/AiAgent`) and a server-side proxy at `/ckeditor-ai-agent/ai/chat` that forwards to whatever provider the AI module has configured — so the credential stays on the server and the browser never sees it, and swapping providers is a configuration change rather than a rewrite.

**The endpoint is built carefully, which is worth stating because AI proxies frequently are not.** It is `methods: [POST]` only, requires the `use ckeditor ai agent` permission, and — unusually — carries `_csrf_token: 'TRUE'`, so a third-party page cannot drive it with a logged-in editor's session. The client may name a model, but the value is validated against `~^[a-zA-Z0-9._:/-]+$~` and only overrides the configured default; there is no arbitrary-URL proxying anywhere in the flow. Responses stream, so long generations appear progressively rather than as a timeout.

**What to plan for is cost, not compromise.** Anyone holding `use ckeditor ai agent` can send arbitrary prompts through the site's provider account, and can select the model — including a more expensive one than the site's default. Nothing here rate-limits or budgets. On a site with many editors that is a real spending exposure, so grant the permission deliberately, watch the provider's usage dashboard, and consider provider-side spend limits rather than relying on the module.

The administrative permission `administer ckeditor ai agent` is `restrict access: true`.

---

- Generate draft text inside the editor.
- Rewrite a selected passage.
- Summarise a long article in place.
- Change the tone of a paragraph.
- Expand a bullet list into prose.
- Translate a passage without leaving the editor.
- Keep the AI credential server-side.
- Swap AI providers without changing the editor.
- Stream long generations progressively.
- Restrict AI generation to specific roles.
- Choose a model per request within an allowed pattern.
- Add AI assistance to selected text formats.
- Watch provider spend across an editorial team.
- Apply provider-side budget limits.
- Configure a default model for the site.
- Audit who holds the AI usage permission.