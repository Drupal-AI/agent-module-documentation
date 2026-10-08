# Configuration

Telegram Embed has no central settings page. Instead, you enable it per **text
format** by adding its toolbar button and switching on its filter. This is a
required step — until you do it, editors will not see the Telegram Post button and
pasted links will not turn into embeds.

## Set up a text format

1. Log in as a user with the **Administer filters** permission (an administrator by
   default).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
3. Click **Configure** next to the text format you want to support Telegram embeds
   — for example **Full HTML**. (Choose a format your trusted editors use, not one
   available to anonymous commenters.)
4. In the **CKEditor 5** toolbar configuration, drag the **Telegram Post** button
   from the *Available buttons* tray up into the *Active toolbar*.
5. Scroll down to the **Enabled filters** section and tick the **Telegram Embed**
   filter so its placeholders are converted to live widgets on render.
6. Click **Save configuration**.

## How the pieces fit together

The **toolbar button** is what editors use to insert a post: it opens a small
balloon form, you paste a Telegram post URL like `https://t.me/channel/123`, and
the module validates it and stores an escape‑safe placeholder in the body.

The **Telegram Embed filter** is what turns that stored placeholder into the actual
Telegram widget when the page is displayed. You need *both* switched on for the
same format — the button to author embeds and the filter to render them.

## A note on validation and privacy

The module validates every URL server‑side: the stored `data-tg-post` value must
match a `channel/postid` pattern, and anything else is discarded, which prevents
the feature from being abused to inject arbitrary markup. Bear in mind, though,
that a rendered embed loads Telegram's third‑party widget in the visitor's browser
and can set Telegram's cookies — if you are subject to consent rules (for example
in the EU) treat these embeds as non‑essential third‑party content.
