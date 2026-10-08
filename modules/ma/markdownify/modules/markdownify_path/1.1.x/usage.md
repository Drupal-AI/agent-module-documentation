Markdownify Path Alias lets you reach the Markdown version of content by appending `.md` to a human-readable path **alias** (e.g. `/blog/my-post.md`), not just to the internal `/node/1` canonical path.

---

The submodule registers one inbound path processor, `MarkdownifyAliasPathProcessor`
(service `markdownify.alias_path_processor`, tagged `path_processor_inbound` at priority
101 — just above the parent module's processor). On each request it checks whether the path
ends in `.md`; if so it strips the extension, resolves the remaining string through the path
alias manager (`path_alias.manager`), and — when the alias maps to a real system path —
rewrites the request to the Markdownify system path so the normal Markdownify controller
serves Markdown. It requires the core `path` module and the parent `markdownify`. There is no
configuration, no admin UI, no permissions, and no schema; enabling it is the whole setup.
When it is enabled, the parent module also stops force-aliasing the canonical `<link
rel="alternate">` URL, deferring alias handling to this processor.

---

- Serve `/en/articles/sample-article.md` instead of only `/node/1.md`.
- Give AI crawlers Markdown at the same friendly URLs humans see.
- Keep Markdown URLs SEO-friendly by using aliases rather than internal node paths.
- Let editors share a readable `.md` link for a page.
- Support `.md` on multilingual alias paths (the alias is resolved through the alias manager).
- Provide Markdown at a taxonomy term's aliased URL (e.g. `/topics/drupal.md`).
- Avoid exposing internal entity ids in Markdown URLs.
- Combine friendly aliases with the parent module's `Accept: text/markdown` negotiation.
- Offer a predictable `<alias>.md` convention across the whole site.
- Fall through gracefully to the original path when an alias does not resolve.
- Let a documentation pipeline mirror your alias structure as `.md` files.
- Add alias-based Markdown access without touching the parent module's configuration.
- Keep canonical `.md` URLs (`/node/1.md`) working alongside alias `.md` URLs.
- Make `.md` links copy-pasteable from the address bar for any aliased page.
- Support content-first URLs for LLM ingestion tools that follow sitemaps of aliases.
