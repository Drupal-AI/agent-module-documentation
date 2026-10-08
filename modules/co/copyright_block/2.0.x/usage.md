Copyright Block provides a configurable block that renders a copyright message with an automatically maintained year range — you set a start year and separator, and the current year is appended dynamically so a footer notice like "© 2015 - 2026" stays current without edits.

---

The module defines a single Block plugin (`copyright_block`, `CopyrightBlock`) that you place
like any block (`/admin/structure/block`). Its block form collects a **start year** (numeric,
1900–current), a **separator** string, and the **copyright statement text** (a `text_format`
field, so it uses a filter/text format). The text is rendered as `processed_text` with token
replacement, and the module ships a token type `copyright_statement` with a `dates` token
(`hook_token_info()` / `hook_tokens()` in `copyright_block.module`). `[copyright_statement:dates]`
expands to just the start year when it equals the current year, or `start<separator>current`
(e.g. `2015 - 2026`) when the current year is later — so the "to" year is always today's year.
Site-wide defaults for separator and text live in the `copyright_block.settings` config object;
per-block config overrides them. Depends on core Token. Because the token needs the block's
`config` context, the `dates` token only resolves inside this block's rendering.

---

- Show an always-current "© 2015 - 2026 Company" notice in the site footer.
- Display a single-year copyright when the site launched this year.
- Automatically roll the end year over on January 1 with no manual edit.
- Customize the separator (dash, en-dash, "to", slash) between start and current year.
- Place multiple copyright blocks in different regions with different text.
- Use a rich-text format for the statement (links, entities, styling).
- Add the dynamic year range into a longer legal/footer sentence via the token.
- Set a fixed start year matching the organization's founding year.
- Keep the notice consistent across a multisite by exporting the block config.
- Combine with core/contrib tokens available in the statement's text format.
- Localize the statement text per block for multilingual footers.
- Provide a footer "all rights reserved" line that never goes stale.
- Reuse the default text/separator from `copyright_block.settings` across new blocks.
- Show the block only on certain pages using core block visibility conditions.
- Restrict the copyright block to specific themes or regions.
- Render the year range in a sidebar as well as the footer.
- Present the notice with brand-specific punctuation via the separator field.
- Update the standing copyright statement text site-wide via the default config.
- Avoid hardcoding the year in templates or twig by using the block.
- Give editors control of the copyright text without touching code.
