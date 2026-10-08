# Configure CKEditor 5 YouTube

No global settings page. Configuration is **per text format**:

1. Go to *Configuration → Content authoring → Text formats and editors*
   (`/admin/config/content/formats`) and edit a format that uses **CKEditor 5**.
2. Drag the **YouTube Embed** button from *Available buttons* into the *Active toolbar*.
3. The plugin's settings (attribute checkboxes) appear below the toolbar; adjust and **Save**.

Adding the button is what enables the plugin for that format; its config is stored in the
`editor.editor.<format>` entity under the plugin id.

## Settings (`enabled_optional_attributes`)

Schema `ckeditor5.plugin.ckeditor5_youtube_embed_youtubeembed` (a sequence of strings). The settings
form (`buildConfigurationForm`) shows a checkbox per **optional iframe attribute**:

`align`, `frameborder`, `height`, `width`, `longdesc`, `name`, `scrolling`, `tabindex`, `title`,
`allowfullscreen`, `referrerpolicy`, `allow`, `class`.

- **Default** (`defaultConfiguration`): all of the above **except** the deprecated ones.
- **Deprecated** (labelled "(deprecated)", off by default): `align`, `frameborder`, `longdesc`,
  `scrolling`.
- `class` is special-cased: enabling it whitelists the specific value
  `class="youtube-embed-responsive youtube-embed-fixed"` (not arbitrary classes).

## Allowed elements / HTML (`getElementsSubset`)

The plugin declares the elements it permits in the editor (and, therefore, what the text-format
filter must allow so embeds survive filtering):

- Always: `<iframe>` **with a required `src` restricted** to
  `https://www.youtube.com/*`, `https://youtube.com/*`, `https://m.youtube.com/*`.
- Plus each enabled optional attribute (merged onto the iframe rule).
- Always: `<lite-youtube>` and
  `<lite-youtube videoid videostartat videotitle params playlabel class="youtube-embed-responsive youtube-embed-fixed">`.

Because the `src` is allow-listed to YouTube hosts, editors cannot use this button to embed an
arbitrary third-party iframe — it only accepts YouTube URLs. (This is an editor/filter constraint,
not a claim about other iframe filters you may have enabled on the format.)

## Static config (`ckeditor5_youtube.ckeditor5.yml`)

Declares the plugin, toolbar item `youtubeEmbed`, front-end library `ckeditor5_youtube/youtubeembed`,
admin library `ckeditor5_youtube/admin.youtubeembed`, and the baseline `elements` list. The runtime
subset (above) narrows/expands the iframe attributes per the saved settings via
`getDynamicPluginConfig()`, which passes `enabled_optional_attributes` to the JS as
`youtube.enabled_optional_attributes`.

## Front-end rendering (lite-youtube)

`ckeditor5_youtube_page_attachments()` (`hook_page_attachments`) attaches
`ckeditor5_youtube/lite-youtube` (`js/vendor/lite-youtube.js`, loaded as an ES module) on **every**
page, so any `<lite-youtube>` element rendered in content becomes a lightweight click-to-load player.
Responsive styling is in `css/youtube.responsive.css`.

## Notes

- No Drush and no permissions — access is governed by who can administer text formats and who can
  use the format.
- Embedded video markup is standard HTML in the field value; ensure the text format's allowed-HTML
  (managed automatically when the button is enabled) keeps the `<iframe>`/`<lite-youtube>` rules.
