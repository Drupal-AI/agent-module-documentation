# Configuration

There are two things to do: set the widget's options on the settings form, and
place the block in a region.

## Open the settings form

1. Log in as a user with the **Administer google_translator settings** permission
   (or core *Administer site configuration*).
2. Go to **Configuration → Regional and language → Google Translator**, or
   navigate directly to `/admin/config/regional/google-translator`.

## Settings, field by field

- **Display mode** — how the selector is laid out:
  - **Simple** (default) — the most compact form.
  - **Horizontal** — shows a "Powered by Google" label beside the selector.
  - **Vertical** — shows the "Powered by Google" label beneath the selector.
- **Available languages** — a checkbox list of roughly one hundred Google
  Translate languages (codes such as `pt`, `es`, `fr`, `de`, `ja`, `ar`,
  `zh-CN`). Tick exactly the languages you want to offer. The default is
  Portuguese and Spanish. If you leave this empty the block shows "No languages
  available for translation" instead of a selector, so pick at least one.
- **Service disclaimer title** — the heading of the optional disclaimer modal.
- **Service disclaimer text** — the body of the modal. If you leave this **blank,
  no modal is shown** and translation starts immediately. If you enter text,
  visitors see an Accept / Do Not Accept modal the first time they use the
  selector and must accept before the page is translated. Admin-filtered HTML is
  allowed here.

Click **Save configuration** when done.

## Place the block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Next to the region you want (header, sidebar, footer, …), click **Place
   block**, find **Google Translator**, and place it.
3. In the block form, the **Title** you set becomes the visible link text (the
   default is "Translate this page"). Set the usual visibility conditions if you
   only want it on certain pages, then save.

You can place the block more than once — for example in different regions or
scoped to different sections with visibility conditions.

## Translating the disclaimer text

The disclaimer title and body are registered with Drupal's Config Translation
system, so on a multilingual site you can translate them per language from the
configuration translation UI.

## Deploying the configuration

All settings live in one exportable configuration object, so both the language
list and the disclaimer travel with your exported configuration between
environments.
