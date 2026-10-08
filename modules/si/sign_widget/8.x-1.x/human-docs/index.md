# Signature (sign_widget) — manual setup guide

**Signature** (`sign_widget`) lets a person draw a signature in the browser on
an HTML5 canvas and stores the result as a file. It works in two places: as a
widget on a core **image** field (the drawing is saved as a PNG and attached to
the entity) and as a **CKEditor 5** button (the drawing is saved as an SVG in
the editor's inline-images folder). Its display name in the admin list is simply
"Signature", but its machine name — the name you use in Drush and Composer — is
`sign_widget`. Do not confuse it with the separate `signature` module, which is
a text signature for user profiles.

The module depends only on core's **Image** module. On Drupal 8 through 12 it
loads the underlying signature-pad JavaScript from a CDN, so there is no library
to download by hand. There are no submodules and no central settings form —
everything is configured per-field in an entity's *Manage form display* (and, for
the editor button, in *Text formats and editors*).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no settings page. After enabling the module you work entirely through
the field UI:

1. Create (or reuse) an **image** field on the content type, user, or other
   entity where you want a signature. In the image field settings it helps to
   uncheck *Alt field required* and *Title field required*.
2. Go to the entity's **Manage form display**, and for that image field choose
   the **Sign** widget. The form now shows a drawing canvas instead of a file
   upload. The module supports multiple signatures and a Bootstrap 5 button
   toolbox.
3. To sign inside rich text, open **Configuration → Content authoring → Text
   formats and editors** (`/admin/config/content/formats`), edit a format that
   uses CKEditor 5, and drag the **Signature** button into the toolbar. When a
   user signs, the drawing is saved as an SVG under the `inline-images` folder.

Because a signature canvas is exposed to whoever can use these fields, give the
signing capability only to trusted roles and keep the safety warning above in
mind.
