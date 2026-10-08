# Configuration

Codepen Field has two parts to set up: optional site-wide defaults, and the field
you add to a bundle.

## Site-wide defaults

1. Log in as a user with the **Administer codepen** permission.
2. Go to **Configuration → Media → Codepen**, or navigate directly to
   `/admin/config/media/codepen`.
3. Set the module-wide default options (for example the default tabs and display
   behaviour). These apply as the starting point for new fields; individual
   formatters can override them per field.

## Add a Codepen field to a bundle

1. Go to your entity bundle's **Manage fields** (for a content type: **Structure
   → Content types → *(type)* → Manage fields**).
2. **Add field** and choose the **Codepen Embed** field type. If you want to allow
   several pens on one entity, set the field to allow more than one value.

## Configure the input widget

On the bundle's **Manage form display**, use the **Codepen** widget. Editors
paste a CodePen **URL**; the module derives the pen id and user id from it, and
the default tabs (HTML/CSS/JS/result) can be selected.

## Configure the display formatter

On the bundle's **Manage display**, choose one of two formatters for the field:

- **Codepen embed** (`codepen_embed`) — renders the live, interactive embed.
  Settings:
  - **Size** — a preset embed size, or **responsive**.
  - **Height** — a custom height, used when the size is set to custom.
  Each value in a multi-value field renders its own embed.
- **Codepen URL** (`codepen_url`) — renders a plain link to the pen instead of an
  embed. Use this when you would rather not load CodePen's external embed script
  (see the privacy note below).

## A note on third-party embeds

The live embed formatter loads **CodePen's external embed script** in the
visitor's browser, which means a request is made to codepen.io when the embed
renders. If third-party requests are a concern on your site, prefer the URL
formatter, which links out without loading the external script.

## Importing pens (optional)

A **Feeds** target is available, so you can map imported values onto the Codepen
field if you use the Feeds module to bring in content.
