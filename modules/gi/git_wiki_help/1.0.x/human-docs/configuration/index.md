# Configuration

Git wiki help has a small settings form where you tell it where your cloned wiki
lives, how to render it, and where it came from. Open it from the module's
*Configure* link on **Extend** (**Administration → Extend**) or under
**Configuration**.

## The settings, field by field

- **Wiki directory** — the directory where the cloned wiki lives and where the
  module looks for Markdown files. **You must clone the Git wiki into this
  directory yourself** — the module never clones or syncs. If you leave this blank,
  the default directory name `git_wiki_help` is used, so clone your wiki there.

- **HTML filter format** (text format) — the text format used *after* the Markdown
  is converted to HTML by the CommonMark library. Choose a format that **allows
  all the HTML elements and attributes** your Markdown produces (headings, lists,
  tables, images, code blocks, and so on). A restrictive format will strip
  legitimate wiki markup, so pick or create one that is permissive enough for
  documentation.

- **Origin of the wiki repository** — the URL of the source wiki. It is used to add
  the original link reference in the footer of each rendered wiki page, so readers
  can trace a page back to its source.

- **Allow clearing all the files already created** — a maintenance checkbox.
  Normally, when the module renders a page it turns any images it finds into
  **permanent** Drupal managed files. Ticking this option instead sets those
  managed images back to **temporary**, which lets Drupal's cron clean them up
  after a while (roughly six hours). Use it when you want to reset the image files
  the module has been keeping.

## After saving

Save the form, then open **Help → Git wiki help**. The Markdown files in your
configured directory are rendered as help pages, laid out in three columns (page
table of contents, content, and an index of the other pages).

## Optional: diagrams

If your Markdown uses Mermaid diagram syntax and you want it rendered as diagrams
rather than code, add a Mermaid integration library to your site.
