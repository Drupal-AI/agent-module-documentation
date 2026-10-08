# Insert View — manual setup guide

**Insert View** (`insert_view`) lets editors embed a Views listing straight into
any formatted text field by typing a short tag. Write something like
`[view:latest_news=block_1]` in a node body, a custom block, or a paragraph, and
the module replaces that tag with the fully rendered output of that view when the
page is displayed. It is the quickest way to drop a listing into the middle of a
piece of content without reaching for a Views block, Layout Builder, or a custom
template.

Under the hood the whole module is a single **text-format filter**. You enable the
filter on the text formats where you want it, and from then on the
`[view:…]` tag works in any field using one of those formats. The tag can name a
specific display, pass contextual-filter arguments (slash-separated, just like a
view's URL, and even pulled from the current path with `%1`, `%2` placeholders),
and cap the number of rows with `limit:N` (`limit:0` shows all results).

Because the filter renders **whatever view display the tag names**, it is
powerful — and that is also its main caution. Anyone who can write text in a
format that has the filter enabled can embed any view display, so you should only
turn it on for text formats that trusted roles use, and make sure your view
displays have sensible access settings. The module needs core's **Views** module
and works on Drupal 8.8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Insert View has no settings page of its own. You switch it on per text format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to use it

### 1. Enable the filter on a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. **Configure** the format you want the tag to work in. (Consider making a
   dedicated format such as *Editorial HTML* for trusted editors rather than
   enabling it everywhere — see the security note below.)
3. Under **Enabled filters**, tick **Insert View**.
4. Check the **Filter processing order**. Place Insert View **before** *Convert
   line breaks into HTML* (so a tag on its own line isn't wrapped in `<p>`), and be
   careful with *Limit allowed HTML tags* — if it runs after Insert View it can
   strip the rendered view's markup.
5. Save.

### 2. Write a tag in your content

In any field using that format, type a tag. The general form is:

```
[view:name=display=args=limit:number]
```

Examples:

- `[view:latest_news]` — the view's default display.
- `[view:latest_news=block_1]` — a specific display.
- `[view:related=block_1=%2]` — pass the third path component as a contextual
  argument (on `/node/12` this passes `12`).
- `[view:products=page_1=electronics/on-sale=limit:5]` — two arguments and a
  five-row cap.
- `[view:latest_news===limit:0]` — the default display, no arguments, all rows.

If the view doesn't exist or the visitor lacks access to that display, the tag
simply renders nothing (no error).

### Security note

The filter will render **any** view display named in a tag — including the
`default` display, which is often not access-restricted. Grant the filter only on
formats that trusted roles use, and review the access settings on every view
display, not just page displays.
