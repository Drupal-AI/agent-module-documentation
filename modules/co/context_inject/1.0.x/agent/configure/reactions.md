<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Context Inject reactions

Configured entirely inside the **Context** UI (requires the Context module's *administer contexts* permission).

## Inject HTML snippet (`AttachSnippet`)
1. Create or edit a context.
2. Add reaction **Inject HTML snippet**.
3. Paste the full HTML/JS into the **HTML Snippet** textarea.
4. Choose **Position**: Bottom (default) or Top.
5. Save. The snippet renders via `Markup::create()` on every page the context's conditions match — including any `<script>` you include.

## Attach library (`AttachLibrary`)
1. Add reaction **Attach library** to a context.
2. Provide the machine name of a Drupal asset library (`module_or_theme/library_name`).
3. The library is attached on matched pages.

## Scoping
Which pages get the injection is controlled by the context's own **conditions** (path, role, content type, etc.) — this module contributes only the reactions.

## Security
- The snippet is output unescaped. Anyone who can edit a context can inject arbitrary site-wide JavaScript, so restrict *administer contexts* to trusted roles.
- Prefer **Attach library** over inline snippets where you can, so assets go through Drupal's library/aggregation pipeline.
