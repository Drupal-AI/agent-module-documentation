# Configuration

Media Resizer is configured on each **text format** that uses CKEditor 5 — there
is no separate global settings page. You add the toolbar button, enable the render
filter so sizes show up on the front end, and (optionally) set width limits.

## Add the button and enable the filter

1. Log in as a user with the **Administer filters** permission (an administrator
   by default).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
3. Edit a text format that uses **CKEditor 5** and allows embedded media.
4. In the CKEditor 5 toolbar configuration, drag the **Media Resizer** button into
   the active toolbar.
5. On the same format's **Filters** list, enable **Apply resize dimensions to
   embedded media** — this filter reads the stored dimensions and applies them to
   the rendered image on the front end. Without it, resizing works in the editor
   but is not reflected on the published page.
6. Click **Save configuration**.

## Set minimum and maximum width limits

The plugin exposes a small settings form (reached from the plugin's controls in
the CKEditor 5 toolbar configuration) where administrators can set the **minimum**
and **maximum width** allowed, in pixels. These guardrails stop editors from
shrinking an image to near nothing or blowing it up beyond a sensible size. Leave
them at sensible bounds for your design, then save the text format.

## Save

Click **Save configuration** on the text format. The button, limits, and render
filter take effect immediately for any field using that format.

## Using it after configuration

When editing content, embed a media image and click it. An overlay with eight
handles appears — drag any of them to resize, watching the live width × height
label. Or click the resizer toolbar button to open the balloon form and type
exact values in px, %, em, vw, or vh. In pixel mode you can lock the aspect ratio,
and quick presets (25%, 50%, 75%, 100%, and "Original") are one click away. The
size is stored on the embed, not on the media entity, so the same image can be
sized differently in different pieces of content.
