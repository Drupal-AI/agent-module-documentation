<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Zookeeper is a text-format filter that swaps animal words (dog, cat, lion, …) in filtered text for their matching emoji.
---
The module provides a single `@Filter('filter_zookeeper')` (type `TYPE_MARKUP_LANGUAGE`) extending `FilterBase`. Its `process()` runs a case-insensitive `str_ireplace()` over the text using a built-in map of roughly 70 animal names to emoji (🐕, 🐈, 🦁, 🐘, 🦈, …) and returns a `FilterProcessResult`. It is a whimsical, self-contained presentation filter with no settings, routes, services or external calls.

Because it uses `str_ireplace` on whole substrings, matches are not word-boundary aware (e.g. "cat" inside "category" would be replaced), so it is best enabled on formats used for informal content. It performs no sanitisation and should sit alongside the normal HTML-filtering pipeline of the text format.

Setup: enable the module, go to a text format's configuration, enable the "Zookeeper Filter", position it appropriately in the filter order, and save; text using that format will then show animal emoji in place of animal words.

---

- Replace animal words with emoji in filtered text
- Enable the Zookeeper Filter on a text format
- Turn 'dog' into a dog emoji in content
- Add a whimsical touch to informal content
- Position the filter in a format's filter order
- Apply case-insensitive animal-to-emoji replacement
- Cover ~70 animals (lion, elephant, shark, and more)
- Use on comment or basic HTML formats for fun output
- Avoid custom code for simple emoji substitution
- Combine with standard HTML filters in the pipeline
- Restrict filter configuration to administer filters
- Render emoji for animal names in node bodies
- Enable per text format rather than site-wide
- Keep the filter self-contained with no external calls
- Demonstrate a minimal FilterBase implementation
- Brighten user-generated content with animal emoji
