# Configuration

Media Gallery has no single "settings" page — the form at **Structure → Media
gallery settings** exists only to host the Field UI tabs. Instead, the real
configuration happens in two places: on each **gallery** you create, and on the two
**blocks** you place. This page walks through both.

## Create and set up a gallery

1. Go to **Content → Media galleries** (`/admin/content/media-gallery`) and click
   **Add media gallery**.
2. Fill in:
   - **Title** *(required)* — the gallery's name and page heading.
   - **Description** — optional rich text shown with the gallery.
   - **Images** — add media with the Media Library picker. This field is unlimited,
     targets any media type, and happily accepts images, video files, and oEmbed
     media (YouTube/Vimeo) side by side.
   - **Use pager** *(on by default)* — paginate the gallery on its page.
   - **Items per page** *(default 12)* — how many items per page when the pager is on.
   - **Reverse** *(off by default)* — show the images in reverse order without
     re‑sorting the field.
3. Save. The gallery now has its own page and appears in the `/galleries` list.

### Add your own fields to galleries

Because the gallery is a real fieldable entity, you can attach extra fields — a
caption, a category, a location. Go to **Structure → Media gallery settings →
Manage fields** (`/admin/structure/media-gallery/fields`) and add fields exactly as
you would on a content type. The Manage form display and Manage display tabs on the
same page control how those fields are edited and shown.

## Place a gallery block

Media Gallery ships two blocks, both under the **Media Gallery** category in
**Structure → Block layout**:

| Block | What it shows |
|-------|---------------|
| **Media Gallery** | One gallery you choose |
| **Latest gallery items from all galleries** | The newest media across every gallery |

To add one, go to **Structure → Block layout**, click **Place block** in the region
you want, and pick the block. Both blocks show only **published** media, newest
first, capped at the item count you set. Their settings are the same except the
first block adds a gallery picker.

### Block settings, field by field

- **Gallery** *(Media Gallery block only, required)* — choose which gallery this
  block displays.
- **Number of items to show** *(default 5)* — how many recent media items appear.
- **Layout settings** — pick the arrangement from a preview selector. Choosing a
  layout reveals that layout's own options:
  - **Grid** *(default)* — a responsive grid; set the number of **columns**.
  - **Featured image grid** — a grid with one hero item spanning extra columns/rows.
  - **Horizontal** — a horizontal strip.
  - **Vertical** — a vertical stack.
  - **Swiper** — a swipeable carousel (requires the `swiper_formatter` module).
- **Image Styles** — choose the **thumbnail image style** for the clickable
  thumbnail and the **PhotoSwipe image style** for the full‑screen modal (leave the
  modal style empty to use the original image).
- **View all link** — optionally show a **"View all"** link back to `/galleries`.
  You can set the link **text**, its **position** (top, bottom, left, right, or
  under the title), and extra **CSS classes** (defaults to Drupal's small primary
  button classes).

Save the block. It refreshes automatically whenever galleries or their media
change.

## Permissions

The module ships nine permissions at **People → Permissions**. Grant them to the
roles that should manage galleries:

- **Administer media gallery** — the settings/Field UI area (this one is restricted
  and should stay with trusted admins).
- **Access media gallery overview** — see the gallery listing.
- **Add media gallery entities** — create galleries.
- **Edit own / Edit any media gallery entities** — edit galleries.
- **Delete own / Delete any media gallery entities** — delete galleries.
- **View published / View unpublished media gallery entities** — control who sees
  published versus unpublished galleries.

The create/edit/delete/view split follows Drupal's standard own‑vs‑any pattern, so
you can, for example, let editors manage only the galleries they created.
