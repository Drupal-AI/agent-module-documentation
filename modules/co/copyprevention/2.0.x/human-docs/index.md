# Copy Prevention — manual setup guide

**Copy Prevention** (`copyprevention`) makes it harder for visitors to copy the
text and images on your Drupal site. It can switch off text selection, block
copy‑to‑clipboard, and disable the right‑click context menu; for images it can
lay a transparent GIF over larger pictures so a "Save image as…" grabs a blank
file instead, and it can tell search engines not to index your images.

Everything is off by default — you turn on exactly the deterrents you want from a
single settings form. The body‑level options add `onselectstart`, `oncopy`, and
`oncontextmenu` handlers to the page; the image options are applied with a small
bit of JavaScript; and the search‑engine options send a `noimageindex` signal
via an HTTP header, a `<meta>` tag, or robots.txt rules.

It is worth being honest about what this module does and does not do: these are
**client‑side deterrents only**. They raise the friction of casual copying and
drag‑to‑desktop image saving, but a determined visitor can still use view‑source,
browser devtools, or a direct image URL. Think of it as a "please don't" sign
rather than a lock. You can also exempt trusted roles (editors, admins) with a
permission so the deterrents never get in the way of real content work.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (optionally) add RobotsTxt for the robots.txt rules.
2. [Configuration](configuration/index.md) — the settings form, option by option.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → User interface → Copy
Prevention** (`/admin/config/user-interface/copyprevention`). Access to it is
gated by the **Administer copy prevention** permission. Nothing is protected
until you tick some boxes and save.
