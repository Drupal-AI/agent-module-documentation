<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EBT Accordion adds a ready-made "Accordion / FAQ" block type: a stack of collapsible Question/Answer sections you place in a region or in Layout Builder.

---

Install it with Composer (`composer require drupal/ebt_accordion`) and enable it; it pulls in **EBT Core**, **jQuery UI Accordion** and **Paragraphs**, and the Media "Image" type should exist first (EBT Core uses it for background images). Enabling the module creates a `block_content` block type **EBT Accordion/FAQ** — add one at `block/add/ebt_accordion`. Each accordion section is a Paragraph with a **Title / Question** and a **Text / Answer**, both formatted-text fields (so a question can include an icon or bold text), and you add as many sections as you need under the block's **Content** tab. The block's **Settings** tab controls the behaviour: a visual **style** preset (`Default`, `Text only`, `Plus/Minus icons on the left/right`), whether sections are **collapsible**, whether they start **all closed** or **all opened**, an **active** panel index, a **height style**, options to force-collapse on tablet/mobile, and the shared EBT design options (margins, borders, background, container width). At display time the module initialises **jQuery UI Accordion** on the block using those settings; page-wide colours and responsive breakpoints come from the EBT Core settings form at `admin/config/content/ebt-settings`. The module has no settings page, permissions or routes of its own, and on uninstall it intentionally leaves the block type in place so existing content is not lost. One usability note worth planning for: content inside a collapsed panel is not found by the browser's in-page (Ctrl+F) search, which matters on long FAQ or policy pages.

---

- Build an FAQ page with collapsible question-and-answer sections.
- Fold a long policy or terms document into expandable sections.
- Place an accordion block in any theme region.
- Add an accordion inside a Layout Builder layout.
- Give editors a reusable collapsible content block.
- Choose the "Plus/Minus icons on the left" style for a classic FAQ look.
- Choose the "Text only" style for a minimal, icon-free accordion.
- Start the accordion with all sections collapsed to shorten the page.
- Start with all sections open, but collapse them on mobile.
- Open a specific panel by default via the active-index setting.
- Make the accordion non-collapsible so one panel is always open.
- Put Font Awesome icons or bold text in a question via formatted text.
- Show product specifications grouped by section.
- Present course modules or lesson lists collapsed.
- Group related support questions by topic.
- Reduce page length on dense, content-heavy pages.
- Share colour and breakpoint defaults with other EBT blocks via EBT Core.
- Theme the accordion by overriding its Twig templates.
- Export a configured accordion block with your site configuration.
- Reuse the same accordion block across multiple pages.
