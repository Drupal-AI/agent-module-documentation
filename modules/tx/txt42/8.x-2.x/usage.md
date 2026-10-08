<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Txt42 adds the Txt42 ChatGPT-based AI writing tool to the rich-text editor via the N1ED CKEditor integration.

---

Txt42 (https://txt42.ai) is a third-party AI writing assistant that plugs into CKEditor through the N1ED framework. This Drupal module is a thin bridge: it declares the dependency on `ckeditor` and `n1ed` so that, once N1ED is configured, the Txt42 feature is available inside the editor for generating and rewriting body text. It has no routes, permissions, services or blocks of its own — it exists to wire the editor plugin into a Drupal text format.

Setup: enable N1ED and this module, then enable the N1ED/Txt42 plugin on the relevant text format's toolbar under Text formats and editors. AI generation happens against the Txt42/N1ED service, so review that provider's data-handling and any API-key requirements before enabling it for editors. Because it depends on the legacy `ckeditor` (CKEditor 4) module, confirm your site still provides that editor.

---
- Add an AI text-writing button to the CKEditor toolbar.
- Let editors generate draft copy with ChatGPT inside the editor.
- Rewrite or expand selected text using the Txt42 assistant.
- Enable the feature per text format via N1ED configuration.
- Speed up content drafting for marketing or blog pages.
- Provide writing assistance to non-expert content authors.
- Combine AI drafting with the N1ED visual editing tools.
- Keep AI writing inside the standard node edit form.
- Restrict AI editing to formats available to trusted roles.
- Generate first drafts that editors then refine manually.
- Reduce time spent on boilerplate body text.
- Offer inline suggestions without leaving the editor.
- Bridge Drupal's CKEditor to the Txt42 SaaS assistant.
- Roll AI writing out gradually by text format.
- Evaluate the Txt42 provider before enabling for all editors.
