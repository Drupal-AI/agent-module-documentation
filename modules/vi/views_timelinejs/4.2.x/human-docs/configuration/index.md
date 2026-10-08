# Configuration

There are two things to configure: the timeline itself (per View) and, once
site-wide, where the TimelineJS library loads from.

## Build a timeline View

1. Go to **Structure → Views** and create or edit a View of the content you want
   to show — for example a View of your "Milestones" or "Events" content type.
2. Add the **fields** you will map to the timeline. At minimum you need a **date
   field** for the start of each slide; also add title, body, and image fields as
   needed. (This format uses fields, not a row template, so all slide content
   comes from the fields you add here.)
3. Set **Format → TimelineJS**.
4. Click the format's settings and fill in the three areas below.

### Map your fields to slide properties

Each mapping is one of the fields you added to the View. **Start date is the only
required one** — if you leave it unset the timeline renders nothing and shows a
warning.

| Property | What it does |
|----------|--------------|
| **Start date** *(required)* | When the slide/era begins. The mapped field must output a date string PHP can parse; rows with an unparseable date are skipped. |
| **End date** | When the slide/era ends. Required for era rows. |
| **Display date** | Friendly text shown instead of the raw start/end dates. |
| **Headline** | The slide's headline (HTML allowed). |
| **Body text** | The slide's body (HTML allowed). |
| **Media** | A media URL, embed, or image. Image fields are handled specially — the raw image URL is extracted for you. |
| **Media credit / caption / thumbnail** | Credit line, caption, and the small thumbnail shown in the navigation strip. |
| **Background image** | A full-bleed background for the slide (image fields handled specially). |
| **Background color** | A CSS color (hex or keyword) for the slide background. |
| **Group** | Groups events into horizontal lanes (e.g. by department or category). |
| **Type** | Chooses what kind of entity each row is — see below. |
| **Unique ID** | A stable per-slide identifier, used for bookmarkable per-slide URLs. |

**Row types.** The value of the mapped **Type** field decides what each row
becomes:

- empty or any other value → a normal **event slide** (the default);
- `title` or `timeline_title_slide` → the single **title/intro slide** (if more
  than one row is typed this way, the last one wins);
- `era` or `timeline_era` → a shaded **era band** (needs both a start and an end
  date, otherwise the row is skipped).

### Presentation options

These map onto TimelineJS's own settings: **font**, **width** (default `100%`),
**height** (default `40em`), **hash bookmarks** (bookmarkable per-slide URLs),
**scale factor** (default 2), **timenav position** (bottom or top) and its
height, **start at end** (open on the last slide), and **language** (leave empty
to use the site language where TimelineJS supports it). There is also an extra
**Start at current** option that opens the timeline on the slide nearest today —
it overrides "Start at end" when both are set.

## Choose where the TimelineJS library loads from (site-wide)

1. Go to **Configuration → Development → Views TimelineJS**
   (`/admin/config/development/views-timelinejs`). This form is gated by the
   **Administer site configuration** permission.
2. Pick a **library location**:
   - **CDN (latest)** — the Knight Lab CDN, newest release. Convenient, but not
     recommended for production since the version can change under you.
   - **CDN 3.9.7** or **CDN 3.8.18** — the CDN pinned to a specific tested
     version. Safer for production.
   - **Local** — a local copy you provide. The library must live in
     `libraries/timeline3` (with its `css/` and `js/` subfolders). Use this for
     privacy or offline sites.
3. Save.

The shipped default is **CDN (latest)**. You can also set it from the command
line:

```bash
drush cset views_timelinejs.settings library_location cdn_3.9.7 -y
drush cget views_timelinejs.settings library_location
```

## Tip: previewing your field mappings

In the Views **preview** pane the module dumps the raw timeline data structure as
plain text instead of rendering the widget. That is handy for checking that your
field mappings and dates are being read the way you expect before you view the
real page.
