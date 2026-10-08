<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor Widget Menu collects widget buttons into a single dropdown, so a toolbar carrying many of them stays one row.

---

The CKEditor toolbar fills up faster than anyone expects. Core supplies formatting, lists, links, media and source; then a site adds a code block, an accordion, a callout, an embedded view, a block embed, an icon picker and a table of contents, and the toolbar wraps onto a second and third row — at which point every button is harder to find, the editing area shrinks, and on a narrow screen the toolbar occupies more of the viewport than the text. Grouping the site-specific widgets under one labelled dropdown restores the row and, more usefully, separates "things that format text" from "things that insert a component", which is a distinction editors already have in their heads. Version **1.1.0** on `^8` through `^11`. Two things to check with any toolbar customisation, because a toolbar is an input surface before it is a decoration. **The dropdown must be keyboard operable** — reachable in the tab order, opened with Enter or Space, navigated with arrow keys, closed with Escape, and returning focus to the trigger — since an editor who works by keyboard loses every widget behind a mouse-only menu. And **the grouping is a decision that should be made once and applied consistently**, because a widget that lives in the toolbar on one text format and inside the menu on another is a widget editors will report as missing.

---

- Reduce a crowded CKEditor toolbar.
- Group widgets into a dropdown.
- Keep the toolbar on one row.
- Separate formatting from components.
- Improve editing on narrow screens.
- Tidy a toolbar with many buttons.
- Group site-specific widgets together.
- Improve editor orientation.
- Reduce toolbar wrapping.
- Give components a labelled menu.
- Improve a text format's usability.
- Organise a complex editor toolbar.
- Reduce visual noise while editing.
- Group embed buttons together.
- Improve mobile editing.
- Make widgets easier to find.
- Standardise toolbar organisation.
- Reclaim editing area height.
