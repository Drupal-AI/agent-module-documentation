# Quote — manual setup guide

**Quote** (`quote`) adds a **"quote" link** below nodes and comments. When a user
clicks it, the text of that node or comment is copied into a new comment (or reply)
form, so they can respond to specific content — the familiar quoting behaviour of
forum and discussion threads.

The module offers up to four link variants: *quote selected* (copy only the text the
user has highlighted), *quote all* (copy the whole body), and on comments *reply and
quote all* and *reply and quote selected*. You choose which variants appear. A link
only shows when the content's type is enabled for quoting, comments are open, and the
current user has both the core **post comments** permission and Quote's own **use
quote** permission. The quoting itself is done with a small JavaScript helper, and
this **4.x branch supports CKEditor 5**, so quotes drop cleanly into the rich‑text
editor.

You can tune how much text is quoted (a character limit), whether HTML tags are kept
or stripped, whether the original author's name is prepended, and the CSS selectors
the JavaScript uses to find the comment box, the body text, and the author name.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   (it depends only on core Node and Comment).
2. [Configuration](configuration/index.md) — choose which quote links appear, which
   content types allow quoting, and set the limit, HTML handling, and selectors.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → Quote**
(`/admin/config/content/quote`) and requires the **administer quote** permission.

## How to use it

1. Enable the module and grant **use quote** (and core **post comments**) to the
   roles that should see quote links.
2. On the settings form, pick which content types allow quoting and which quote
   modes to expose.
3. Users then see quote links under eligible nodes and comments; clicking one opens
   a comment/reply form pre‑filled with the quoted text.
