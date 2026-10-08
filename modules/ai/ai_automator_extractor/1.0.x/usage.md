<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Automator Extractor pulls links, e-mails, images, files, or regex matches out of a source text field using plain PHP and regular expressions — no AI call involved.

---

AI Automator Extractor is a set of AI Automators field-processor plugins that handle the deterministic, "just use a regular expression" parts of an AI Automators workflow. Instead of sending text to an LLM, each plugin runs PHP/regex over a source field and writes the results into a target field on entity save: extract every link or e-mail address from unstructured text, pull image or file URLs out of scraped HTML, run an arbitrary regular expression to fill a text/string field, or count how many times a pattern occurs and store the number in an integer field. The Image and File extractors additionally fetch the matched URLs server-side and save them as image/file entities on the target field. It ships seven `AiAutomatorType` plugins and supersedes the older AI Interpolator Extractor on Drupal 10.3+. It has no routes, permissions, config, or Drush commands of its own, and depends on the AI module's `ai_automators` sub-module (in the "AI Tools" package). Supports Drupal 10.3 and 11.

---

- Extract all links from an unstructured text field into a link field.
- Extract all e-mail addresses from text into an e-mail field.
- Extract image URLs from scraped HTML and save them as image entities.
- Extract file URLs from HTML and save them as managed files.
- Filter extracted links by a configurable disallowed-extension list.
- Run any regular expression over a text field and store capture groups.
- Run a regular expression over a `string` field (separate plugin).
- Count regex matches and store the total in an integer field.
- Chain after a scraper Automator to turn scraped pages into structured fields.
- Populate media galleries automatically from article body content.
- Build link-list fields from free-text references.
- Deterministically parse content without incurring LLM cost.
- Constrain image extraction by min/max resolution from the field config.
- Limit how many files/images are downloaded via cardinality and amount/offset.
- Validate extracted links with `FILTER_VALIDATE_URL` before storing.
- Validate extracted e-mails with `FILTER_VALIDATE_EMAIL` before storing.
- Replace the legacy AI Interpolator Extractor on Drupal 10.3+.
- Mix regex extraction steps with AI steps in one Automators chain.
- Extract data from `text`, `text_long`, `string`, `string_long`, `text_with_summary`, and `link` fields.
- Keep extraction logic in configuration rather than custom code.
