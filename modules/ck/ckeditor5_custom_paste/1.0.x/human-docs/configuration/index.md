# Configuration

CKEditor 5 Custom Paste is configured **per text format** — there is no global
settings page. Each CKEditor 5 text format can turn the plugin on independently and
define its own list of tags to exclude from paste transformations.

## Open the text format editor

1. Log in as a user with the **Administer filters** permission (an administrator by
   default).
2. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
3. Click **Configure** next to the text format whose editor is CKEditor 5 (for
   example *Full HTML* or *Basic HTML*).

## Enable the plugin for this format

In the CKEditor 5 toolbar configuration, add the Custom Paste plugin to the active
toolbar (drag its button up from the list of available buttons). Enabling it for
the format is what activates the custom paste handling for content edited with that
format.

## Define the tags to exclude

With the plugin enabled, its settings appear in the CKEditor 5 plugin settings
area below the toolbar. Here you list the **HTML tags to exclude** from the paste
styling transformations. Any tag you list is left as-is when content is pasted,
while everything else is subjected to the module's cleanup. This is what lets you
protect specific structures — table layouts are the common example — from being
reformatted or stripped, while still cleaning up the rest of the pasted markup.

Start with a small, deliberate list and test it against real content: because paste
filtering is **lossy by design**, an editor who pastes a formatted table and gets
plain rows will simply paste again. Keep the tags your site's own styles can
actually express, and discard the rest.

## Save

Click **Save configuration** at the bottom of the text format form. The new paste
behaviour applies immediately to any content edited with that format.

## Important: this is not a security control

Keep in mind that paste filtering is **editorial hygiene, not security**. It runs
in the browser and can be bypassed with the Source editing button or an API write.
The security boundary is the text format's **filter chain** (for example
`filter_html`), applied when content is rendered regardless of how the markup got
into the field. Configure `filter_html` correctly for security; use Custom Paste
only to keep pasted content tidy and on-brand.
