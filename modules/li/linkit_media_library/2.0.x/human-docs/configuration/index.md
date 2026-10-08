# Configuration

Linkit Media Library has **no settings page of its own**. The Media Library button appears
in CKEditor 5's Link dialog only when three things line up: a Linkit profile with a media
matcher, a text format that uses Linkit's filter and CKEditor extension, and (on
HTML-restricted formats) the `target` attribute allowed on links.

## 1. A Linkit profile with a media matcher

Linkit profiles live at **Configuration → Content authoring → Linkit profiles**
(`/admin/config/content/linkit`). Edit the profile your text format will use (often
**Default**) and make sure it has a **Media** matcher:

1. Open the profile's **Manage matchers** tab.
2. If there is no *Media* matcher, click **Add matcher**, choose **Media**, and save.
3. Optionally edit the matcher to restrict which media types the picker offers (its
   **Bundles** setting) — for example limit it to *Document* so editors only link to files.
   Leave the bundles empty to offer every media type.

On install this module adds a media matcher to the *default* profile automatically, so you
may find one already there. If you use a different profile, add it yourself as above.

## 2. The text format and editor

Edit the text format at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) — for example **Full HTML**:

1. Make sure the **Link** button is in the CKEditor 5 toolbar (the media-library button
   lives *inside* the link dialog, not on the toolbar itself).
2. Under **CKEditor 5 plugin settings → Drupal link**, tick **Linkit enabled** and choose
   the Linkit profile from step 1.
3. Under **Enabled filters**, tick **Linkit URL converter**.
4. **Save configuration.**

## 3. Allowed HTML (restricted formats only)

If the format uses **Limit allowed HTML tags**, make sure `target` is permitted on the `<a>`
tag — otherwise the `target="_blank"` this module adds to inserted links will be stripped
out. (The module declares this element automatically when its plugin is enabled, so on most
setups it is already handled.)

## Using it as an editor

With everything in place, highlight some text, click the **Link** button, and in the link
dialog choose **Media Library**. Browse, search or upload, pick a media item, and the link
is inserted — pointing at the media entity and set to open in a new tab.

## Good to know

- The link stores the media item's UUID, so it keeps working if the file is later replaced
  or the media alias changes — Linkit's URL converter rewrites the address at render time.
- The dialog title, size and the `target="_blank"` behaviour are fixed and not configurable.
- If the button does not appear, the usual causes are a missing media matcher on the
  profile, the *Linkit URL converter* filter not being enabled, or Linkit's CKEditor
  extension not being turned on for the format.
