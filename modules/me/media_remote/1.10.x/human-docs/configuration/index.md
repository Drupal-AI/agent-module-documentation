# Configuration

Media Remote has no settings form. You configure it by creating a **media type** that
uses the "Remote Media URL" source and then choosing the **provider formatter** on
that type's display. The order matters — follow the steps below.

## The setup order (important)

There are three things that must be true for a Remote Media type to work:

1. A media type whose source is **Remote Media URL**.
2. A source field (a plain text field) on that type — created for you when you add the
   type.
3. **The provider formatter set on the type's *default* display.** This one is easy
   to forget, and it's essential: it selects the provider, drives URL validation, and
   auto-names new items. If you skip it, saving a media item fails with an error.

The module actively steers you through this: right after you create a type using this
source, it shows a warning and sends you to the **Manage display** screen so you can
pick the formatter.

## Step 1 — Create the media type

1. Go to **Structure → Media types → Add media type**
   (`/admin/structure/media/add`).
2. Give it a name (for example "Remote Loom" or "Remote document").
3. Set **Media source** to **Remote Media URL**.
4. Save.

Drupal creates the type and a text field to hold the URL, then drops you on the
type's **Manage display** page with a reminder to configure the formatter.

## Step 2 — Choose the provider on Manage display

On the type's **Manage display** tab:

1. Find the source field (the "Remote Media URL" field).
2. Set its **Format** to the provider you want — the list includes options like
   **Remote Media - Loom**, **Remote Media - Google Drive**, **Remote Media - Google
   Maps**, **Remote Media - Box**, **Remote Media - Dropbox**, **Remote Media -
   Brightcove**, **Remote Media - Panopto**, **Remote Media - Matterport**, **Remote
   Media - Apple Podcasts**, and more (around 20 providers).
3. Click the cog to set the embed options:
   - **Width** and **Height** — the iframe dimensions for the embed. Set these once
     and every item of this type embeds at a consistent size.
   - **App key** — only for the Dropbox formatter, which needs a Dropbox app key to
     render its preview.
4. **Update**, then **Save**.

> **One provider per type.** Because the provider is chosen on the display, each media
> type embeds one provider. If you need both Loom and Panopto, create two media types.
> The provider is always read from the *default* display, even when the item is shown
> in another view mode.

## Step 3 — Add remote media

Now editors can add items:

- Via **Content → Media → Add media → *(your type)*** (`/media/add/<type>`): paste the
  provider URL and save.
- Via the **Media Library** modal in any media field: the modal shows a URL box for
  this type — paste the link and click **Add**.

Either way, the URL is validated against the provider you chose. If someone pastes a
URL from the wrong service, they get a clear error listing example valid URLs for the
expected provider. New items are auto-named from the URL (an episode slug, a document
id, and so on), so editors usually don't have to type a title.

## Notes

- All Remote Media types share a single underlying URL field storage. That's normally
  invisible, but it means deleting that field affects every Remote Media type.
- Media Remote doesn't fetch remote thumbnails — items use a generic placeholder
  thumbnail in the library.
- Adding a **new, unsupported provider** is a developer task (subclassing the module's
  formatter base) — see the [`agent/`](../agent/start.md) docs.
