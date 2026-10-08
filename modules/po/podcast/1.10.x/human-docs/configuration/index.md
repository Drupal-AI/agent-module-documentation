# Configuration

Podcast has no global settings page. You configure everything on a Views **Feed**
display: you build the View, choose the podcast format and row, add ordinary Views
fields for your data, and then map each field onto a podcast XML tag using the
select boxes in the format settings.

## Build the feed View

1. Go to **Structure → Views → Add view**
   (`/admin/structure/views/add`). Set the base to the content type that holds your
   episodes (for example *Episode* or *Article*). A Page or Block display is
   optional. Save and edit.
2. On the View, click **Add** and choose **Feed**. This creates a feed display.
3. Under **Format → Show**, choose **RSS Feed**, then in its settings select
   **Podcast RSS Feed**. This is the module's channel‑level style.
4. Still under **Format**, set the **row** style to **Podcast Fields**. This builds
   each episode `<item>`.
5. Add ordinary Views **fields** for every value you want in the feed — title, body,
   the audio file's URL, publish date, cover image, and so on. For static values
   (like a fixed category string) add Views' **Custom text** field and map that.
6. Map the fields using the select boxes described below.
7. Under **Feed settings**, set the feed **path** (conventionally ending in
   `rss.xml`), then **Save**.

Mapping works one property at a time: for each podcast tag you pick which View
field supplies its value. Choosing **- None -** simply leaves that tag out of the
feed.

## Channel settings — the show

These live in the **Podcast RSS Feed** style settings and describe the show as a
whole.

- **Title, Link, and Last build date** are the three required mappings — pick the
  View fields that provide the show title, the show's web page URL, and the build
  date.
- **Generator** is a free‑text field (default *"Podcast module for Drupal"*), and
  **Language** is a free‑text ISO‑639 code such as `fr-ca`. If you leave Language
  empty the feed falls back to the current interface language.
- **Description** maps a field to the show's summary.
- **iTunes fields** let you map the show's **explicit** flag, **owner name** and
  **owner email** (required by Apple), **author**, **summary**, **keywords**,
  **cover image**, and **category**. The category understands a
  `Category/Subcategory` format, and you can list several separated by commas — each
  becomes a nested `<itunes:category>` tag.
- **iTunes type** is a select: **episodic** (default) for a normal show or
  **serial** for a story meant to be heard in order.
- **Copyright** uses the Select or Other widget — either pick a View field *or* type
  a literal copyright line. (This is the reason the module needs Select or Other.)
- **Podcast Index fields** cover the newer namespace: a globally unique
  **podcast:guid**, **funding** link and its link text, **license**, **medium**,
  a **new feed URL** (for when you move the show), and **locked** (which tells other
  platforms whether they may import your feed).
- **Value‑4‑Value payments** is a group of fields for crypto/streaming‑payment
  metadata — the value type, method, suggested amount, and each recipient's name,
  type, address, and split. Map these only if you use Value‑4‑Value; otherwise leave
  them as **- None -**.

## Episode settings — each item

These live in the **Podcast Fields** row settings and describe each episode.

- **Audio enclosure** is the heart of an episode. The **enclosure URL** is
  required — map it to the field holding the audio file's URL. You can also map the
  file **length** (size in bytes) and **type** (MIME type, e.g. `audio/mpeg`).
- **iTunes item fields**: **author**, **keywords**, **explicit** (true/false),
  **duration**, **summary**, **image**, and the **season** and **episode** numbers.
- **Podcast Index item fields**: a **chapters** URL (JSON), a **transcript** URL
  (the MIME type is detected automatically from the file extension — `.vtt`, `.srt`,
  `.json`, `.html`, otherwise plain text), a **soundbite** (start time, duration,
  and description) to highlight a clip, and **person** entries (a comma‑separated
  field becomes one `<podcast:person>` per name, for listing hosts and guests).
- The standard Views RSS fields (title, link, description, author, date, guid) still
  apply as well. Any link field values should start with a leading slash — the
  module turns them into absolute URLs for you.

## A note on HTML in descriptions

You don't need to do anything special to include HTML in the show or episode
summary. The module automatically wraps fields mapped to **description** or
**itunes:summary** in a CDATA block, so formatted body text stays valid inside the
XML feed.

## Validate before submitting

Load the feed's path in your browser to confirm it renders, then run it through a
podcast validator such as <https://podba.se/validate/> (or Apple Podcasts Connect)
before submitting the feed URL to any directory. Fix any reported missing tags by
mapping the corresponding fields above.
