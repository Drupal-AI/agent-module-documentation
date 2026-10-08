# Filter HTML Plus — manual setup guide

**Filter HTML Plus** (`filter_html_plus`) does one focused thing: it extends
core's **"Limit allowed HTML tags and correct faulty HTML"** filter so you can
whitelist an attribute *globally*, on every tag at once, instead of listing it tag
by tag. With core alone, allowing `class` on your elements means writing
`<a class>`, `<p class>`, `<span class>`, and so on for each tag. This module adds
a `<*>` wildcard: put `<* class tabindex>` in the **Allowed HTML tags** list and
those attributes are permitted on any element you already allow. It depends only
on core's Filter module.

The wildcard works *within* core's sanitization — core still strips tags and
attributes you have not allowed, so this is a convenience layer, not a way around
the filter. Because widening the allow‑list widens what markup users can enter,
treat this as a tool for **trusted formats only** and be deliberate about what you
whitelist (see the security note below).

There is no site-wide settings page — you use it by editing a text format's
allowed HTML.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You use it by editing the
allowed-HTML list of a text format, described in "How to use it" below.

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Click **Configure** on the format you want to widen.
3. Make sure **Limit allowed HTML tags and correct faulty HTML** is one of the
   format's enabled filters.
4. In that filter's **Allowed HTML tags** field, add a wildcard entry alongside
   your existing tags. For example, to allow `class` and `tabindex` on every
   allowed element:

   ```
   <* class tabindex>
   ```

5. Click **Save configuration**.

## A security note before you widen a format

Whatever you whitelist globally becomes allowed on *every* tag in that format, so
the allow‑list is only as safe as its contents:

- **Never** globally allow event-handler attributes (anything starting with
  `on`, such as `onclick`, `onerror`) — they run JavaScript and open an XSS hole.
- **Avoid** globally allowing `style`, which can be abused for injection and
  clickjacking-style tricks.
- Keep the global whitelist to safe, presentational attributes like `class`,
  `id`, `tabindex`, or specific `data-*` attributes.
- Only apply this to formats used by **trusted** authors, never to formats
  exposed to anonymous or untrusted users (such as comment formats).
