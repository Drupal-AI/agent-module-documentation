# Configuration

You create and manage popups from the admin UI. Each popup is saved independently, so
you can run several at once and toggle them on or off individually.

## Create a popup

1. Log in as a user with the **Administer simple_popup_blocks** permission.
2. Go to **Configuration → Media → Add simple popup blocks**
   (`/admin/config/media/simple-popup-blocks/add`).
3. Fill in the form (fields explained below) and save.
4. **Clear caches** (`drush cr`, or *Configuration → Development → Performance →
   Clear all caches*) — the module reminds you, and the popup will not appear until you
   do.

## The form, field by field

### What to show

- **Unique identifier** — a short name for this popup. It is lowercased and any
  unusual characters become underscores, and it is used to build the popup's CSS
  selectors, so keep it simple (e.g. `newsletter`).
- **Type** — choose what the popup targets:
  - **Drupal block** — enter the block's configuration id. The module wraps it as the
    rendered block element automatically.
  - **Custom CSS id/class** — enter a bare selector name (no leading `.` or `#`), then
    use **CSS selector** to say whether it is a **class** or an **id**. This lets you
    pop up any element already present in your markup.

### Where and how it appears

- **Layout** — the on‑screen position: top‑left, top‑right, bottom‑left, bottom‑right,
  center, top‑center, top bar, bottom bar, left bar, or right bar.
- **Trigger method** — how the popup opens:
  - **Automatic** — opens on its own; set **Delay** (seconds to wait after the page
    loads).
  - **Manual (on click)** — opens when the visitor clicks a **Trigger selector** you
    provide (this one *must* start with `.` or `#`).
  - **Before browser/tab close** — opens on exit intent, as the visitor is about to
    leave.
- **Width** — the popup width in pixels (default 400).

### How often it appears

- **Visit counts** — which visits should show the popup. `0` means every visit; `1,2`
  means only the first and second visits, and so on.
- **Use time frequency** — instead of counting visits, throttle by time. When on, pick
  **Time frequency**: hourly, daily, or weekly.
- **Cookie expiry** — how many days to remember that a visitor dismissed the popup.
  Set `0` to forget as soon as the browser closes (so it shows again next session).

### Controls and behavior

- **Overlay** — dim the page behind the popup.
- **Enable escape** — let the ESC key close the popup.
- **Close button** — show a close (×) button.
- **Minimize button** / **Show minimized button** — let visitors collapse the popup
  instead of closing it, and optionally show the minimized handle.
- **Status** — the on/off switch. Only enabled popups are attached to pages.

## Styling your popup

The module ships **no** popup design of its own. Open a popup's edit page and it lists
the CSS selectors it generates for that popup — for example a parent
`#spb-<identifier>`, a `.<identifier>-modal` box, and `.<identifier>-modal-close` /
`.<identifier>-modal-minimize` controls. Add rules for those selectors in your theme's
CSS to style the popup however you like.

## Manage existing popups

Go to `/admin/config/media/simple-popup-blocks/manage` to see all your popups in a
table, where you can **edit**, **delete**, or flip a popup on and off. After any
change, clear caches again so the front end reflects it.

## Permission

- **Administer simple_popup_blocks** — required for all of the add, manage, edit, and
  delete screens above. Grant it only to trusted roles.
