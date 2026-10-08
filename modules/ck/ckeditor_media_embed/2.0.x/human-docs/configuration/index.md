# Configuration

Three things must be wired up before an author can embed media. The first two happen on
a text format; the third is the module's own settings page. Make sure you have already
downloaded the plugin JavaScript (see [Installation](../installation/index.md)) — the
toolbar button does nothing without it.

## 1. Add the "Media embed" toolbar button

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Click **Configure** next to a format that uses **CKEditor 5** (for example *Full
   HTML* or *Basic HTML*).
3. In the CKEditor 5 toolbar configuration, drag the **Media embed** button (labelled
   *"Insert media"*) from *Available buttons* up into the *Active toolbar*.
4. Save the format.

When an author clicks the button and pastes a URL, CKEditor stores a compact
`<oembed url="…"></oembed>` tag in the saved markup.

## 2. Enable the render filter on the same format

The stored `<oembed>` tag is only turned into a real embed at render time by a filter —
without it, the tag renders as‑is and nothing appears. On the same text‑format
configuration page:

1. Under **Enabled filters**, tick **Convert Oembed tags to media embeds**.
2. If the format uses **Limit allowed HTML tags**, make sure the allowed tags permit the
   embed markup (iframes and `<figure>`); the filter injects remote embed HTML, so keep
   it running before any filter that would strip that markup.
3. Save the format.

The filter itself has no settings of its own — it simply needs to be on.

## 3. Choose the oEmbed provider

Which service resolves the pasted URLs is a single setting:

1. Go to **Configuration → Media → CKEditor Media Embed**
   (`/admin/config/media/ckeditor-media-embed/settings`). You need the core **Administer
   filters** permission.
2. The form has one field, **Provider URL** — a template with `{url}` and `{callback}`
   tokens that are filled in per request.

The default is Iframely's proxy, which covers 1700+ providers. You can point it at any
oEmbed endpoint instead:

| Service | Provider URL template |
|---------|-----------------------|
| Iframely (default) | `//iframe.ly/api/oembed?url={url}&callback={callback}&api_key=MYTOKEN` |
| Noembed (no API key) | `//noembed.com/embed?url={url}&callback={callback}` |
| embed.ly | `//api.embed.ly/1/oembed?url={url}&callback={callback}&key=MYTOKEN` |

Only **one** provider is active at a time. Use a proxy such as Iframely or Noembed to
cover many services at once, or point at a single service's oEmbed endpoint to restrict
embeds to just that service. Iframely over HTTPS requires an account/API token in the
URL. Save the form when done.

> **Note:** if the plugin JavaScript is not yet installed, this settings form will show
> the *"run `drush ckeditor_media_embed:install`"* warning instead of the Provider URL
> field. Download the JavaScript first (see [Installation](../installation/index.md)).

## Optional: render a Link field as an embed

The module also provides a field formatter, **"Oembed element using CKEditor Media
Embed provider"**, for **Link** fields. On a Link field's **Manage display** tab, choose
this formatter and each stored URL renders as an embedded player through the same
provider (falling back to a plain link if no embed comes back). This is handy for a
dedicated "media URL" field that should display as the embed rather than a link.

## Verify it worked

Edit a piece of content that uses your configured text format, click **Media embed** in
the toolbar, paste a YouTube (or other) URL, and save. On the rendered page the video
should appear as an embedded player. If you instead see nothing or the raw URL, check
that the **Convert Oembed tags to media embeds** filter is enabled on that format and
that the plugin JavaScript was downloaded.
