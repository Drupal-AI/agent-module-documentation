# Configuration

TOC Filter has no single settings page of its own. You configure it in two places:
you switch the **filter** on per text format, and you choose between **TOC types**
managed by TOC API. This page walks through both, plus the `[toc]` token and the
optional block.

## Enable the filter on a text format

1. Log in as an administrator and go to **Configuration → Content authoring → Text
   formats and editors** (`/admin/config/content/formats`).
2. Click **Configure** next to the format your editors use (for example *Full
   HTML* or a custom "Handbook" format).
3. Under the list of filters, check **"Display a table of contents"**.
4. Make sure the format's **"Limit allowed HTML tags"** filter permits your heading
   tags (`<h2>`, `<h3>`, … `<h6>`) — the TOC is built from those, so if they're
   stripped there's nothing to index.
5. Click **Save configuration**.

## The filter's four settings

Once the filter is checked, it exposes a small settings area on the same page:

- **Type** — which **TOC type** (visual style) to render. This refers to a TOC type
  defined by TOC API (see below). Defaults to `default`. Other built-in choices
  include `simple`, `simple_numbered`, `full`, and `full_numbered`.
- **Auto** — controls automatic insertion when the content has no `[toc]` token.
  Leave it empty to do nothing, or set it to **top** or **bottom** to inject a
  table of contents at the start or end of every page in this format. Handy when you
  want a TOC everywhere without asking editors to add the token.
- **Block** — when on, the TOC is rendered through the "Table of contents" **block**
  instead of inline, and the token is removed from the body. Use this to move the
  TOC into a sidebar (see the block section below).
- **Exclude above** — when on, any headings that appear *before* the `[toc]` token
  are left out of the table of contents. Useful for skipping an intro or lead
  section.

## The `[toc]` token and inline options

In the body of your content, put `[toc]` wherever you want the table of contents.
You can override settings for that one token by adding HTML-style attributes, which
are merged on top of the chosen TOC type's options:

```
[toc]
[toc type="simple"]
[toc type="tree" title="On this page"]
[toc block="true"]
```

- **type** — use a different TOC type for this token only.
- **title** — the heading shown above the table of contents (for example "On this
  page").
- **block="true"** — render this TOC via the block instead of inline.
- **h1**…**h6** — choose which heading levels to include.

Only the **first** `[toc]` token in a page is replaced. If the token ends up wrapped
in a block tag (`<p>[toc]</p>`, `<h2>[toc]</h2>`, and so on), that wrapper is
stripped so the token resolves cleanly.

## Rendering the TOC as a block

To put the table of contents in a sidebar instead of inline:

1. Turn on the filter's **Block** setting, or use `[toc block="true"]` in the
   content.
2. Go to **Structure → Block layout** and place the **"Table of contents"** block
   (category "TOC filter") in the region you want.

The block only appears on a page whose content actually produces a table of
contents; on pages without one it stays hidden.

## TOC types (managed by TOC API)

The **Type** you pick — both in the filter settings and in the token — refers to a
TOC type, which is a configuration entity owned by the **TOC API** module. Manage
these at **Structure → Table of contents** (`/admin/structure/toc`). The built-in
types include Default, Simple, Simple - Numbered, Full, and Full - Numbered. You
can create or clone types there to control the markup, which heading levels are
included, and the CSS classes; TOC Filter just references them by name. This is the
module's listed configuration route.
