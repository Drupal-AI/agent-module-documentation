# URL Embed — manual setup guide

**URL Embed** (`url_embed`) lets content editors turn a plain URL into rich embedded
content. Paste a YouTube or Vimeo link, a tweet, an Instagram or Facebook post, or even
an ordinary news-article URL into a CKEditor 5 text field, and instead of a bare
hyperlink the reader sees the actual embedded video, card, or preview. It does this by
fetching each URL's oEmbed or Open Graph data through the `oscarotero/embed` PHP
library, so it works with any provider those standards cover — no per-site provider
list to maintain.

There are three ways the module can embed a URL, and you can use whichever suits your
site. Two **text filters** work inside a text format: one auto-converts bare URLs typed
into body text into embeds, and the other renders embed tags that are already present.
A **CKEditor 5 toolbar button** gives editors a "paste a URL" dialog instead of typing
markup. And a **Link-field formatter** renders a plain Link field's value as a rich
embed rather than a hyperlink. All of them route their fetches through a shared
`url_embed` service, and other modules can adjust the request per URL via a hook.

The module has a small settings form at **Configuration → Media → URL Embed** for
storing a Facebook/Instagram app ID and secret — required since 2020 to fetch oEmbed
data from those two providers. It depends on core's Editor, Filter, and the contrib
**Embed** module, plus the `embed/embed` (`oscarotero/embed`) Composer library, and
will refuse to install if that library is missing.

This guide is written for a **human** setting the module up in the admin UI. If you
want terse, token-cheap references for an AI coding agent — the filter plugin ids, the
service, and the options-alter hook — read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in the
   `embed/embed` library and the Embed module) and enable it.
2. [Configuration](configuration/index.md) — the text filters, the CKEditor 5 toolbar
   button, and the Facebook/Instagram credentials settings form.

## Where it lives in the admin menu

- The **settings form** (Facebook/Instagram credentials) sits at **Configuration →
  Media → URL Embed** (`/admin/config/media/url_embed`).
- The **text filters** are enabled per text format at **Configuration → Content
  authoring → Text formats and editors**
  (`/admin/config/content/formats`).
- The **CKEditor 5 toolbar button** ("URL Embed") is added from the same text-format
  editing screen by dragging it into the active toolbar.
