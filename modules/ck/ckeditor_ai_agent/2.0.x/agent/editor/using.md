<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using CKEditor AI Agent in the editor

Requires the `use ckeditor ai agent` permission and the **AI Agent** button(s) in the
text format's toolbar. Without the permission the controls are not rendered at all.

## Invocation

- **Slash commands** — type `/` in an empty line to open the AI command menu, then a
  free-form instruction, e.g. `/write a blog intro about open source`. Press **Enter** to
  run, **Shift+Enter** for a newline inside the prompt.
- **Force-insert mid-text** — `Cmd/Ctrl + /` opens a slash command inside existing text.
- **Toolbar buttons** — `aiAgentButton` (general AI menu) and `aiAgentToneButton`
  (tone/rewrite menu). Menu entries come from the seeded/configured command and tone
  vocabularies (Polish, Make Shorter/Longer, Summarize, Continue, Simplify, change tone, …).
- **Selection edits** — select a passage first, then pick a command to rewrite that range.
- **Cancel** — `Cmd/Ctrl + Backspace` aborts an in-flight generation (`AbortController`).

## What happens on submit

1. The plugin assembles a system + user message (including surrounding-content context,
   bounded by `contextSize`/`editorContextRatio`, and any allowed-HTML hints derived from
   the text format) and POSTs it to the same-origin proxy route with the CSRF token.
2. Drupal forwards it to the AI module's default chat provider server-side and streams the
   completion back as SSE. With `streamContent` on (default), text appears progressively.
3. Returned content is passed through `ai-output-filter.js` before insertion: tags outside
   an allowlist are unwrapped (content kept), and URLs are checked against
   `aiOutputSecurity.allowedDomains` — `javascript:`/`vbscript:`/`data:` URLs and
   off-allowlist links are redacted, off-allowlist images swapped for a placeholder. This
   mitigates prompt-injection data-exfiltration (EchoLeak / CVE-2025-32711 class).
4. Inserted HTML then flows through the editor's normal text-format handling and is subject
   to the format's filters on save.

## References / RAG

Include URLs in a prompt (one per line) to have the provider incorporate that material,
e.g.:

```
/Create a blog post summary:
https://example.com/article1
https://example.com/article2
```

(Whether external URLs are actually fetched depends on the configured AI provider; the
DXPR provider supports web research.)

## Notes for operators

- Model selection: the request may name a model, but it is regex-validated server-side and
  only overrides the site default — editors cannot proxy to an arbitrary endpoint.
- Cost: every generation bills the site's provider account. There is no per-user rate limit
  or budget in this module; use provider-side spend controls and grant the permission
  deliberately.
- Troubleshooting: enable `debugMode` for verbose logging and check the browser console;
  verify the provider at `/admin/config/ai/settings` and the status report if requests fail.
