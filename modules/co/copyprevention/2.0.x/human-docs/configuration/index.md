# Configuration

All of Copy Prevention's deterrents are **off until you enable them here**. There
is one settings form with three groups of checkboxes plus one dropdown.

## Open the settings form

1. Log in as a user with the **Administer copy prevention** permission (an
   administrator by default).
2. Go to **Configuration → User interface → Copy Prevention**, or navigate
   directly to `/admin/config/user-interface/copyprevention`.

## Text and page deterrents

The first group controls behavior across the whole page (it adds `on…="return
false"` attributes to the `<body>` tag). Tick any combination:

- **Disable text selection** — visitors cannot highlight article text with the
  mouse, so they cannot easily select‑and‑copy it.
- **Disable copy** — blocks the copy‑to‑clipboard action (`Ctrl/Cmd + C` and the
  copy menu item) everywhere.
- **Disable right‑click (context menu)** — the browser's right‑click menu no
  longer appears, which deters casual "Save image as…" and "Inspect".

## Image deterrents

The second group targets images specifically:

- **Disable right‑click on images** — removes the context menu on `<img>`
  elements only, leaving the normal menu on the rest of the page.
- **Transparent GIF overlay** — floats an invisible 1‑pixel GIF over your images,
  so a right‑click "Save image as…" or a drag‑to‑desktop grabs the blank overlay
  instead of the real picture.
- **Minimum image dimension** — a dropdown (10, 20, 30, 50, 100, 150, 200, 300,
  or 500 pixels; default **150**). The transparent overlay is only applied to
  images at least this wide or tall, so small icons and buttons are left alone
  while hero images and gallery photos are protected.

## Search‑engine (image indexing) deterrents

The third group asks search engines not to index your images. You can combine
these for redundant signals:

- **Send `X-Robots-Tag: noimageindex` HTTP header** — an HTTP‑level instruction
  to skip image indexing.
- **Add a `noimageindex` robots meta tag** — writes
  `<meta name="robots" content="noimageindex">` into the page `<head>`.
- **Disallow image files in robots.txt** — emits `Disallow` rules for image file
  types into robots.txt. **This option requires the RobotsTxt module** (see
  [Installation](../installation/index.md)); without it the option has no effect.

Note that these search‑engine options apply to **everyone**, including users who
have the bypass permission — they are about search crawlers, not about the person
browsing.

## Save

Click **Save configuration**. Changes take effect immediately on the next page
load.

## Exempting trusted users

Copy Prevention adds two permissions:

- **Administer copy prevention** — who can open and change this settings form.
- **Bypass copy prevention** — users with this permission are **exempt** from the
  text and image deterrents (no `<body>` handlers, no overlay JavaScript). Grant
  it to your editor and administrator roles so the deterrents never interfere with
  content work. Note this does *not* exempt them from the search‑engine
  (image‑noindex) options above, which always apply.
