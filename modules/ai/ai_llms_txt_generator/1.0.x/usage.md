Generates a spec-compliant `/llms.txt` file for your Drupal site by summarizing its sitemap.xml with the configured Drupal AI provider.

---

AI LLMs.txt Generator produces an [llmstxt.org](https://llmstxt.org/)-style Markdown summary that tells large-language-model crawlers what a site is about and which pages matter. An administrator sets a sitemap URL (typically the one produced by Simple XML Sitemap), and the module fetches that sitemap over HTTP, groups the URLs by their `<priority>`, and feeds a compact, priority-ranked list to the Drupal AI module's default chat provider (OpenAI, Anthropic, Ollama, or any other configured provider). The AI returns a concise Markdown document — overview, key pages, main topics, site structure — which is stored in the module's config and served as `text/plain` at `/llms.txt`. The generated text can be edited by hand in the settings form, and an optional "manual content" block lets you append hand-written material. Generation happens on demand from the admin form (AJAX) or a POST endpoint; nothing is regenerated automatically. The module ships no entities, plugins, Drush commands, or cron jobs — just two services, one settings form, and two routes.

---

- Publish an `/llms.txt` at your site root so AI crawlers get a curated summary of your content.
- Auto-draft the llms.txt body from your existing sitemap.xml instead of writing it by hand.
- Use the Simple XML Sitemap module's generated sitemap as the input source.
- Point the generator at any absolute sitemap URL (your own site or a staging URL).
- Have the AI prioritize the 10-15 most important pages, ranked by sitemap `<priority>`.
- Let the AI group site URLs into topical categories automatically.
- Pick which AI provider/model produces the summary via the central AI module settings.
- Switch providers (OpenAI to Anthropic to a local Ollama model) without changing this module.
- Set a custom site name and description that seed the AI prompt.
- Regenerate the llms.txt after a content refresh with one click from the admin form.
- Preview the generated Markdown in a textarea before saving it.
- Manually edit the AI output to correct or tighten the summary.
- Append hand-written "manual content" that is served when no AI content exists.
- Serve a friendly placeholder at `/llms.txt` until content is generated.
- Keep `/llms.txt` out of search indexes automatically (the route sends `X-Robots-Tag: noindex`).
- See when the file was last generated ("N ago") in the settings form.
- Generate content programmatically by calling the `sitemap_parser` and `ai_generator` services from custom code.
- Parse a sitemap index (a sitemap of sitemaps) — the parser recurses into child sitemaps.
- Integrate llms.txt generation into a deployment step via the POST generate route.
- Provide model-friendly site metadata as part of an AI/SEO content strategy.
- Restrict who can manage the file with the dedicated "Administer AI LLMs.txt settings" permission.
- Uninstall cleanly — the module deletes its config object on uninstall.
