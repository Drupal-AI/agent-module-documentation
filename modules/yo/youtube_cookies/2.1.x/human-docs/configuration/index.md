# Configuration

YouTube Cookies needs a little configuration before it does anything: the two
required fields (cookie category and provider) tell it *when* a visitor has
consented and *which* banner to talk to. Until both are filled in, no blocking
or pop-up is injected on any page.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → YouTube Cookies**, or navigate directly to
   `/admin/config/system/youtube-cookies`.

## The settings, field by field

- **Enable YouTube cookies** (`enabled`, default *on*) — the master switch. When
  it is off, no façade, pop-up, or filtering runs anywhere. Leave it on for
  normal use.
- **Cookie category** (`cookie_category`, **required**) — the machine name of the
  consent category, in your compliance system, that a visitor must accept before
  videos may play. This must match a category you have defined in OneTrust or EU
  Cookie Compliance.
- **Cookie compliance system** (`provider`, **required**) — pick **OneTrust** or
  **EU Cookie Compliance**. This choice selects the matching JavaScript
  integration the module loads, so it must be the banner you actually run.
- **Action when the user has not consented** (`action`, default **Popup**) —
  *Popup* shows the blocking, GDPR-compliant consent pop-up over the façade.
  The alternative, *no-cookies domain*, swaps the embed to `youtube-nocookie.com`;
  it is **deprecated and not fully GDPR compliant**, and is slated for removal —
  prefer *Popup*.
- **Popup message** (`popup_message`) — the HTML message shown in the pop-up. It
  ships with a sensible default that explains YouTube may use the visitor's data
  and links to Google's privacy policy. Edit it to match your tone.
- **Manage / Accept / Exit button labels** (`button_manage`, `button_accept`,
  `button_exit`) — the three button texts, defaulting to *Manage cookies*, *I am
  OK with it*, and *Exit*.

The message and all three button labels are **translatable** per language via
config translation, so a multilingual site can localise the whole pop-up.

Click **Save configuration** when done. As soon as a cookie category and a
provider are both set, the module attaches its JavaScript and begins replacing
YouTube videos with the façade.

## Switching on the CKEditor integration

Blocking of YouTube videos in **Media oembed** fields and the contrib **Iframe**
field type happens automatically once the module is configured. YouTube iframes
pasted into **rich-text (CKEditor)** content are a separate opt-in, handled by a
text-format filter:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit the format your editors use.
2. Under **Enabled filters**, tick **Youtube cookies filter**.
3. The format's allowed HTML must permit `<iframe>` **with a `class` attribute**,
   so that the façade's CSS classes survive filtering. If the format uses *Limit
   allowed HTML tags*, add `<iframe class>` to the allowed-tags list. The module
   enforces this — it will show an error when you save the format if the class
   attribute is missing.
4. Save the format.

## A note on OneTrust vs EU Cookie Compliance

The module does not decide consent itself — it asks your chosen provider whether
the configured cookie category has been accepted. So the category machine name
you enter here must be a real category in that system, and the banner must be
installed and configured independently. If videos never unblock, first check
that the category name matches and that the correct provider is selected.
