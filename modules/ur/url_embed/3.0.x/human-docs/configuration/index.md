# Configuration

There are three independent things you can configure, and you don't need all of them.
The two **text filters** are the core of the module — turn them on for a text format
and pasted URLs become embeds. The **CKEditor 5 toolbar button** is an optional
convenience that gives editors a paste dialog. The **settings form** only matters if
you embed Facebook or Instagram content.

## 1. Text format filters

Both filters live on a text format's edit screen at **Configuration → Content
authoring → Text formats and editors → (your format)**
(`/admin/config/content/formats/manage/<format>`). Tick the ones you want in the
**Enabled filters** list, then set their order in **Filter processing order**.

| Filter | What it does |
|--------|--------------|
| **Convert URLs to URL embeds** (`url_embed_convert_links`) | Rewrites bare URLs typed into the text into embed tags. |
| **Display embedded URLs** (`url_embed`) | Renders those embed tags into the provider's actual embed HTML (fetched through the `url_embed` service). |

**Order matters:** the "Convert URLs" filter produces the tag that the "Display
embedded URLs" filter consumes, so **Convert URLs must run before Display embedded
URLs** in the processing order. If you only want editors to embed via the toolbar
button (not by pasting raw URLs into body text), you can enable just the "Display
embedded URLs" filter.

Each filter has a couple of settings:

- **Convert URLs to URL embeds** has a **URL prefix** option (empty by default). Leave
  it empty to convert every recognised URL. Set it to a marker string (for example
  `EMBED-`) if you want only URLs that start with that marker to be converted — a way
  to give editors control over which links become embeds.
- **Display embedded URLs** has two options:
  - **Enable responsive embeds** — wraps each embed in a responsive container so
    iframes scale to the width of the content area.
  - **Default aspect ratio** — a percentage (default `66.7`) used as a fallback aspect
    ratio when a provider does not report its own (for example `56.25` for 16:9).

## 2. CKEditor 5 toolbar button

To let editors embed a URL through a dialog instead of typing anything, add the **URL
Embed** button to the format's CKEditor 5 toolbar. On the same text-format edit screen,
drag the **URL Embed** button from the available items into the active toolbar and
save.

The button only works on formats where the **Display embedded URLs** (`url_embed`)
filter is enabled — the dialog produces an embed tag, and that filter is what renders
it. As a safeguard, the dialog is only reachable when the button is actually present in
the toolbar, so adding the filter without the button does not expose the dialog.

## 3. Facebook / Instagram credentials

Facebook and Instagram have required an app token to fetch their oEmbed data since
October 2020. If you want to embed Facebook or Instagram posts, provide app
credentials on the settings form:

1. Go to **Configuration → Media → URL Embed** (`/admin/config/media/url_embed`). This
   form is gated by the **Administer URL Embed** permission.
2. Fill in:
   - **Facebook App ID** — your Facebook app's ID.
   - **Facebook App Secret** — that app's secret.
3. Save. The form performs a live check against Facebook and tells you whether the
   credentials are valid ("app is active") or wrong ("invalid credentials").

When both values are set, the module automatically builds the required access token for
every Facebook and Instagram embed fetch. You can leave this form blank if you don't
embed content from those two providers — everything else (YouTube, Vimeo, Twitter/X,
plain article links, and so on) works without it. The values are stored in the
`url_embed.settings` config object, which is created the first time you save the form.

## Link-field formatter (bonus)

Outside of text formats, you can render a plain **Link** field as an embed. On the
field's display settings (**Manage display** for the entity), set the Link field's
format to **URL Embed** and its stored URL will be rendered as rich embedded content
instead of a hyperlink.
