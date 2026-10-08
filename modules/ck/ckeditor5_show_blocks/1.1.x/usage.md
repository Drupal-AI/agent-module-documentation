<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor 5 Show Blocks adds a toolbar toggle that outlines every block-level element in the editing area and labels each with its tag name, so an editor can see the structure of what they are writing.

---

A WYSIWYG shows what text looks like and hides what it is, and the gap between those causes most of the markup problems on a content-managed site. A heading that is really a paragraph in bold at 18 points looks like a heading and is not one — so it does not appear in a table of contents, is skipped by a screen reader navigating by heading, and carries no weight for search. An empty paragraph used as a spacer is invisible until the design changes. Nested lists that look right are often two separate lists. A blockquote that is really an indented paragraph loses its meaning entirely. This module wires CKEditor 5's built-in ShowBlocks plugin into Drupal as a text-format toolbar button; when an editor clicks it, the plugin adds a `ck-show-blocks` class to the editable area and the module's CSS draws a dashed outline around each `p`, `div`, `h1`–`h6`, `blockquote`, `ul`, `ol`, `pre`, `section`, `header`, `footer`, `figcaption` and similar element, printing the tag name in its top-left corner. Turning that on makes structure visible in the editor, which is the only place it can be fixed cheaply. Version **1.1.1** on core `^9 || ^10 || ^11`, depending only on the core `ckeditor5` module. The reason to reach for it is usually **accessibility remediation**, and it is unusually effective there because it converts an abstract audit finding — "heading levels are used inconsistently" — into something an editor can see and correct on the page they are editing, without learning what a heading level is. Two practical notes. **It is a view mode rather than a setting to leave on**, since the outlines take space and distract from writing, so its value is in being available when structure is in question rather than always on. And **it shows structure, not correctness**: an `h3` following an `h1` is visible as an `h3`, and whether that is a skipped level is still a judgement the editor has to make — which is why the module pairs naturally with an accessibility checker rather than replacing one. It adds no new allowed HTML (`elements: false`), touches no stored content, and exposes no configuration beyond dragging its button onto a format's toolbar.

---

- See the block-level structure of edited content in the editor.
- Find a fake heading (bold large paragraph) in an article.
- Spot empty paragraphs used as vertical spacers.
- Check heading hierarchy while editing a page.
- Turn an accessibility audit finding into a visible fix.
- See where a blockquote actually begins and ends.
- Debug nested list markup that renders ambiguously.
- Train editors on what semantic block structure means.
- Inspect a migrated article's markup for stray wrappers.
- Find stray `div` elements left in body content.
- Improve consistent heading usage across a site.
- Review a page's document outline before publishing.
- Clean up structure in content pasted from Word.
- Verify that list nesting is a single list, not two.
- Support an ongoing accessibility remediation programme.
- Distinguish real headings from styled paragraphs at a glance.
- Confirm a figure caption is a `figcaption` and not a paragraph.
- Give editors a self-service structure check with no server round trip.
- Add the toggle only to formats whose editors work with rich structure.
- Pair with an accessibility checker so editors both see and judge structure.
