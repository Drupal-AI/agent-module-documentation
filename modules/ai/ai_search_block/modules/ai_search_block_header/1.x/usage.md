AI Search Block Header adds a compact, core-styled header search box that redirects visitors to your AI Search page and auto-runs their query there.

---

This submodule of AI Search Block provides a header block (`ai_search_block_header_block`) that looks like Drupal's core search block but does not call the LLM itself. It renders a small search input; on submit, `AiSearchHeaderForm` redirects to a configured destination path — the page that carries the full AI Search block — with the entered term appended as `?ai_search_block_q=`. A small auto-run script (`js/autorun.js`) on the destination page reads that query parameter, sets it as the AI Search input's value, and submits the form, so the AI answer starts streaming immediately. The destination path is set per block instance. Use it to give every page a persistent search entry point that lands on a dedicated AI answer page. Depends on AI Search Block.

---

- Add a persistent AI search entry point to your site header.
- Match the look of the core search block (same wrapper classes).
- Send visitors to a dedicated page that hosts the full AI Search block.
- Carry the typed query across the redirect via `?ai_search_block_q=`.
- Auto-populate and auto-submit the AI Search form on arrival.
- Configure the destination path per header block instance.
- Keep the header lightweight — no LLM call happens in the header itself.
- Place the header block through the standard Block layout UI.
- Offer a familiar search affordance while using AI-powered answers.
- Provide a fallback default destination path when none is configured.
- Reuse the same AI Search configuration on the destination page.
- Support keyboard submit like a normal search box.
- Scroll smoothly to the AI form when the query auto-runs.
- Keep header markup accessible with a labelled search role.
- Combine with the logging submodule to record header-originated searches.
