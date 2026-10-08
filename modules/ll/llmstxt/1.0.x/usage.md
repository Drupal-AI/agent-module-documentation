<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
llms.txt serves an `/llms.txt` file from Drupal — the emerging convention for telling large language models what a site contains and how it should be read, in the same spirit as `robots.txt` but aimed at AI consumers rather than search crawlers.

---

The `llms.txt` proposal (llmstxt.org) asks a site to publish a Markdown summary at a well-known path: what the site is, which pages matter, where the canonical docs live, so a model retrieving the site gets a curated map instead of inferring one. This module — a fork of RobotsTxt — makes that a Drupal-managed resource. An admin with the module's own `administer llmstxt` permission types the file body into a textarea at `/admin/config/search/llmstxt`; it is stored as a single config value (`llmstxt.settings:content`) and served verbatim at `/llms.txt` as `text/plain` by `LlmsTxtController::content()`, which is public (`_access: 'TRUE'`) because the file must be fetchable by anyone. Other modules can append lines with `hook_llmstxt()`. On first install the body is seeded either from a `sites/default/default.llms.txt` file you provide, or from a generated sample using the site name, slogan and `main` menu. The module does not crawl or enumerate content — the file is whatever an editor curates. Managing it as configuration (rather than a static docroot file) means it survives deployment and travels with a config export. Two honest caveats: the convention is a proposal, not a standard, with only partial adoption, and — like `robots.txt` — it is advisory, expressing a preference with no enforcement against a model that ignores it. The current release is 1.0.0-alpha1.

---

- Publish an llms.txt file describing the site.
- Point AI crawlers at canonical documentation.
- Curate what a model sees first about the site.
- Manage llms.txt without touching the docroot.
- Keep llms.txt through a deployment.
- Export the file's content with site configuration.
- Describe a documentation site's structure for LLMs.
- Highlight the most useful pages for a model.
- Update the file without a code release.
- Link to Markdown versions of key pages.
- Follow an emerging AI-crawler convention.
- Complement robots.txt with AI-specific guidance.
- Describe an API reference for retrieval.
- Reduce misinterpretation of a site by models.
- Restrict llms.txt editing to a dedicated permission.
- Serve the file at the exact required path.
- Version the file alongside site config in Git.
- Seed an initial file from the site's main menu.
- Ship a canned default via sites/default/default.llms.txt.
- Append lines programmatically with hook_llmstxt().
- Delegate file editing to an SEO or content role.
- Experiment with AI discoverability of the site.
