<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LLMs.txt Generator lets an administrator write an `llms.txt` file in a textarea and serves it at `/llms.txt`, the emerging AI-crawler convention that parallels `robots.txt`.

---

Despite the "Generator" name, the content is **entirely hand-authored**: an admin edits a single textarea at `/admin/config/search/llms-txt-generator`, and the module writes that text verbatim to `public://llms.txt` and serves it at the route `/llms.txt` as `text/plain`. It does **not** crawl, enumerate, or summarise site content — the only automatic parts are (1) seeding the field on install from a static bundled template (`templates/default-template.md`) whose `{site_name}`, `{site_url}` and `{date}` placeholders are filled in, and (2) a `hook_cron` that rewrites the physical file if it goes missing. An "Enable llms.txt file" checkbox toggles serving (returns 404 when off), and a JavaScript "Reset to default content" button repopulates the textarea. There are no dependencies beyond core, one permission (`administer llms txt generator`, `restrict access: true`), a config schema, and no Drush commands; the release is **1.0.0-alpha1**. Two caveats belong with any recommendation: the convention is a **proposal, not a ratified standard** with only partial crawler adoption, and — like `robots.txt` — it is **advisory**, expressing a preference while enforcing nothing, so a site that must actually stop AI scraping needs access control, not this file. Functionally it overlaps heavily with the `llmstxt` module (both store hand-written content and serve it); this one additionally persists the content to a real public file and self-heals it via cron.

---

- Publish an `llms.txt` file at the conventional `/llms.txt` path.
- Declare content-usage and attribution preferences to AI crawlers.
- State training-usage and commercial-use terms for your content.
- Suggest rate-limit and cache-retention hints to LLM bots.
- Point ChatGPT, Claude and other models at your key pages.
- Hand-curate which URLs a model is told to read first.
- Edit the file through an admin form instead of deploying a static file.
- Seed a starter file from the bundled default template on install.
- Toggle the file on or off without uninstalling the module.
- Reset the textarea to the default template with one button.
- Fill in site name, base URL and date automatically in the template.
- Serve the file as `text/plain` with a `noindex` robots tag.
- Self-heal the physical `public://llms.txt` file via cron if deleted.
- Complement `robots.txt` with AI-specific guidance.
- Provide an attribution format string for reusers to cite.
- Describe a documentation site's structure for retrieval.
- Advertise a contact address for AI-usage questions.
- Restrict who can edit the file behind a dedicated permission.
- Experiment with AI-facing metadata for a site.
- Keep the served text cache-tag invalidated when config changes.
- Follow the `llmstxt.org` convention while it evolves.
