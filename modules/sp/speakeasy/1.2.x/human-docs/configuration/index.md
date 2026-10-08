# Configuration

Setting Speakeasy up has three parts: choose global defaults, place the block that
does the reading, and (optionally) let visitors save their own preferences.

## Global settings

1. Log in as a user with the **Administer Speakeasy settings** permission.
2. Go to **Configuration → Speakeasy** (`/admin/config/speakeasy`).

From this single settings form you set the site-wide defaults, including:

- **Theme** — choose the bundled **Default** or **Olivero-inspired** styling, or
  opt out entirely to supply your own CSS.
- **Voice selection** — toggle globally whether visitors may pick a voice.
- **Sentence highlighting** — toggle globally whether the highlight-and-scroll
  behaviour is available (it attaches an extra library that wraps each sentence and
  scrolls as words are spoken).
- **Default rate** — the default playback speed.
- **Voice whitelist per browser** — restrict which voices are offered on each
  browser.
- **Language restrictions** — limit the languages that can be used.

The front-end voice loader enforces these limits while matching the visitor's
locale and any saved preferences.

## Place the Speakeasy block

The reading UI is delivered by a block, so add it where you want it via
**Structure → Block layout**:

1. Place the **Speakeasy** block in the region you want (for example above the
   content area).
2. Configure the block:
   - Pick the **output style** — a button set, a media player, or a simple link.
   - Choose the **text fields** to read (the block compiles plain text from the
     fields the visitor is allowed to view).
   - Set per-block options such as **custom button text**, a **highlight toggle**,
     and a **playback rate** override.

The block only renders when there is content available to read, and passes
everything to Drupal's JavaScript behaviours for playback.

## Per-user preferences

If you granted the **Manage Speakeasy user preferences** permission, those
visitors can visit **`/user/speakeasy/preferences`** (linkable from the user
account menu) to save their preferred **voice** and **speed**. Those choices are
honoured whenever the block renders — which is what makes the feature genuinely
usable, since the default synthesis settings suit almost nobody.

## A note on voices

Voice availability and quality depend heavily on the browser and operating
system — some browsers offer many voices of varying quality, others only a few
good ones, and some (for example Chrome on Linux) provide none by default. It is
worth testing on the platforms your audience actually uses; the module's help page
links to compatibility resources.
