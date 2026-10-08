# Configuration

There is no central settings form. Configuration is a single per-media-type toggle,
plus an optional Linkit setup for editors.

## Turn on the /document/{id} redirect for a media type

1. Go to **Structure → Media types** (`/admin/structure/media`).
2. Click **Edit** on a media type whose source is the core **File** source (for
   example your "Document" or "PDF" type). The toggle only appears on File-based
   types — it is hidden for image, remote video, and other source types.
3. Tick **Expose access to file via path /document/[id]**.
4. Click **Save**.

From now on, any media entity of that type answers at `/document/{its id}` and
302-redirects the visitor to the real file. Media types you leave unticked return a
404 for that path, so you can enable the feature selectively.

Because access uses the media entity's own **view** permission, only users who can
view a given media item can follow its `/document/{id}` link. Private files remain
protected by Drupal's file-access system at download time.

## Optional: link to /document/{id} from CKEditor with Linkit

If you have the [Linkit](https://www.drupal.org/project/linkit) module installed,
the module adds two plugins so editors can insert these document links directly:

- A **matcher** — *Media: File Redirect* — which behaves like the normal media
  matcher in the Linkit autocomplete but inserts `/document/{id}` instead of
  `/media/{id}`. It works even when media canonical pages are disabled.
- A **substitution** — *URL that redirects to direct file path* — which you can set
  on a Linkit profile's media matcher so inserted links resolve through
  `/document/{id}`.

To set it up:

1. Go to **Configuration → Content authoring → Linkit profiles**
   (`/admin/config/content/linkit`).
2. Edit the profile your editors use.
3. Enable the **Media: File Redirect** matcher, and/or choose the **URL that
   redirects to direct file path** substitution on the media matcher.
4. Make sure that profile is attached to your CKEditor Linkit button (in the text
   format's editor settings).

Editors will then be able to search for a media item in the link dialog and have
the inserted link point at the clean `/document/{id}` path.
