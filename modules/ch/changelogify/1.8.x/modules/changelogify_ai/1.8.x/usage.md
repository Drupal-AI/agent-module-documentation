Changelogify AI is an optional submodule that adds evidence-backed, bring-your-own-key AI drafting and rewriting of Changelogify release notes using the Drupal AI module's configured chat provider.

---

Changelogify AI lets editors turn recorded change evidence into clearer release notes without leaving the release workflow. It offers three actions: synthesize a full draft release from a release window's eligible evidence, rewrite one release-note item ("humanize"), or rewrite an entire release. It depends on `changelogify` and `drupal/ai (^1.4)` and requires Drupal core `^10.5 || ^11.2`. All processing runs through whatever chat provider Drupal AI is configured with (cloud or local); Changelogify never stores or sees provider credentials. AI is off until an administrator both configures a provider/model and grants a separate consent toggle, and each editor needs the `use changelogify ai` permission. Only a bounded, policy-filtered, redacted payload of eligible evidence is sent; the AI is instructed to cite evidence and never to follow instructions embedded in that evidence. Suggestions are always staged for review and only enter a new release revision when an editor explicitly accepts them — nothing is published automatically. A privacy-bounded operation history (retained per a configurable window) supports troubleshooting without storing release text.

---

- Generate a complete AI draft release from all eligible evidence in a window.
- Rewrite a single release-note item inline in the release edit form.
- Rewrite an entire release's notes with one action.
- Choose an editorial profile (public product, client report, internal technical, concise).
- Set a summary length preset (auto, short, standard, detailed) for synthesis.
- Add one-time, non-saved instructions for a single generation attempt.
- Preview the exact filtered evidence that would be sent before running a job.
- Preview the policy-filtered outbound payload with no network request.
- Require an explicit admin consent toggle before any external processing.
- Gate AI use per role with the `use changelogify ai` permission.
- Reuse the site's default Drupal AI chat provider, or pick a Changelogify-specific one.
- Restrict which event categories (content/extensions/users/configuration/custom) are eligible.
- Apply a privacy preset (recommended / more context / custom) controlling what leaves the site.
- Redact usernames, actor/entity IDs, paths, and unpublished titles from AI payloads.
- Allowlist specific field names whose values may be shared.
- Set organization-wide editorial guidance and an output language (IETF tag).
- Keep AI suggestions staged until an editor accepts them into a new revision.
- Review a side-by-side "current vs suggested" comparison before accepting.
- Track AI operations in a privacy-bounded, filterable history with retention purging.
- Cancel or view the progress of a running synthesis job (owner- or admin-scoped).
- Use a no-JavaScript fallback page to humanize an item.
