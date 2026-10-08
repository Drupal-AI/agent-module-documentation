<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Template Block lets site builders place a block whose entire output is defined by a Twig template file in the active theme.

---

The block plugin (`@Block("template_block")`) has no stored content of its own. Its configuration form takes a single **Template Suggestion** string (validated to `^[a-z0-9_]+$`), which becomes a theme suggestion `template_block__<suggestion>`. The theme developer then creates `template-block--<suggestion>.html.twig` in the theme; until that file exists a placeholder base template is shown telling you which filename to create. `hook_theme_suggestions_template_block()` registers the suggestion and `hook_preprocess_block__template_block()` adds a `template-block--<suggestion>` CSS class to the block wrapper.

Because the actual Twig lives in the theme (created by someone with filesystem access), editors never type Twig or PHP — they only pick a suggestion name, which is regex-validated. Pairing it with Twig Tweak (recommended in the README) lets those templates embed views, blocks, fields, etc. Typical setup: place the block via Block Layout or Layout Builder, set a suggestion, create the matching template in the theme, clear cache.

---

- Place a Template Block via Block Layout and give it a suggestion name
- Place a Template Block inside a Layout Builder section
- Render a fully theme-controlled block without writing a custom module
- Create `template-block--promo.html.twig` for a promotional block
- Add hand-authored HTML/markup regions managed by front-end devs
- Use Twig Tweak inside the template to embed a view
- Use Twig Tweak inside the template to render another block
- Embed a rendered field or entity in a themed block
- Give designers a block whose markup lives in version control
- Provide multiple distinct blocks, each with its own suggestion
- Style each block via the auto-added `template-block--<name>` class
- Prototype block markup quickly without config entity boilerplate
- Show a placeholder until the theme template is created
- Keep block markup in the theme layer instead of the database
- Build a call-to-action block themed entirely in Twig
- Localize static marketing copy through a Twig template
- Reuse one suggestion across multiple placements
- Move presentational markup out of body fields into templates
- Compose a landing-page section from a themed template block
- Validate suggestion names to lowercase/underscore only
