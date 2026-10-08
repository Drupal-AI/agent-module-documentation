# Configuration

Getting Text Resize working is two steps: **place the block** so visitors can see the
controls, and (optionally) **adjust the settings** that decide what gets resized and by
how much.

## 1. Place the Text Resize block

1. Go to **Structure → Block Layout** (`/admin/structure/block`).
2. Find the region where you want the control (a header or sidebar works well) and
   click **Place block**.
3. Search for **Text Resize** and place it.
4. Configure the block as you would any other (title visibility, visibility
   conditions) and save.

The block renders the "A‑" / "A+" links immediately. Anyone who can see content on the
site can use them — the block itself needs no special permission.

## 2. Adjust the settings

Open **Configuration → User interface → Text Resize**
(`/admin/config/user-interface/text_resize`). You need the **administer text_resize**
permission (administrators have it by default). Every setting below is stored in the
`text_resize.settings` config object.

### Scope — what gets resized

- **Scope** (`text_resize_scope`, default `main`) — a CSS selector naming the part of
  the page whose text should grow and shrink. The default `main` targets the main
  content area. Enter a CSS id like `my-container` to resize just one container, or
  `body` to resize the whole page.

### Size limits

- **Minimum size** (`text_resize_minimum`, default `12`) — the smallest font size in
  pixels. This also acts as the starting/default size, so text never shrinks below a
  readable point.
- **Maximum size** (`text_resize_maximum`, default `25`) — the largest font size in
  pixels, capping how big the text can grow.

### Reset link

- **Reset button** (`text_resize_reset_button`, default off) — when ticked, a reset
  ("A") link appears alongside the increase/decrease links so a visitor can return the
  text to its default size in one click.

### Line height (optional)

- **Adjust line height** (`text_resize_line_height_allow`, default off) — when on, the
  line spacing grows along with the font size, which keeps enlarged text comfortable to
  read.
- **Minimum line height** (`text_resize_line_height_min`, default `16`) and **Maximum
  line height** (`text_resize_line_height_max`, default `36`) — the pixel bounds for the
  line height, used only when the option above is enabled.

Click **Save configuration** to apply. Changes take effect on the next page load.

## Setting values from the command line

Every setting can also be read or changed with Drush:

```bash
drush config:get text_resize.settings
drush config:set text_resize.settings text_resize_reset_button true -y
drush config:set text_resize.settings text_resize_scope body -y
```

## Styling the links

The three links carry stable CSS ids — `#text_resize_increase`, `#text_resize_decrease`,
and `#text_resize_reset` (the reset link only when enabled) — so you can restyle them in
your theme's CSS to match your design. For deeper changes you can override the
`text-resize-block.html.twig` template (theme hook `text_resize_block`).
