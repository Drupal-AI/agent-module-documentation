# Configuration

Language Switcher Dropdown has no settings page of its own. You configure it by **placing
the block and editing its block form** — every option below lives in that form.

## Place the block

1. Log in as an administrator and go to **Structure → Block layout**
   (`/admin/structure/block`).
2. Find the region where you want the switcher (for example *Sidebar* or *Header*) and click
   **Place block** next to it.
3. In the picker, choose **Language dropdown switcher** and click **Place block**.

On a standard multilingual site you will usually place the block for the **interface
language** type. If you have made other language types configurable (content or URL
language) under **Configuration → Regional and language → Languages → Detection and
selection**, a separate switcher is available for each.

## The block settings, field by field

### Output type (widget style)

Choose how the dropdown is rendered:

- **Simple HTML select** *(default)* — a plain, fully accessible native `<select>`. No
  JavaScript library needed. Choose this unless you have a specific reason not to.
- **Marghoob Suleman msDropdown** — an animated dropdown; needs the msDropdown JS library.
- **Chosen** — a styled, searchable dropdown; needs the Chosen JS library.
- **ddSlick** — a dropdown with flag thumbnails; needs the ddSlick JS library.

The three fancy styles fall back to nothing useful if their library isn't installed, so stick
with **Simple HTML select** if you haven't added the libraries.

### Language label format

Pick what text each option shows:

- **Translated into the current language** — e.g. shows "German" when the interface is in
  English.
- **Language native name** *(default)* — each language in its own name: Deutsch, Español,
  Français.
- **Language code** — the short ISO code: en, de, fr.
- **Translated into target language** — each option translated into the language it points
  to.

### Width

A fixed width in pixels for the dropdown element (default **165**). Set it to match your
theme; leave it alone for a sensible default.

### Behavior toggles

- **Show all languages** (`showall`) — off by default. When on, every enabled language is
  listed even on a page that has no translation into it (picking one then redirects to the
  front page). Leave off to show only languages the current page can switch to.
- **Hide when only one language** (`hide_only_one`) — on by default. Hides the block
  automatically when just one language is available, so it never shows a pointless
  single‑option selector.
- **Redirect to front page on switch** (`tohome`) — off by default. When on, switching
  language sends the visitor to the front page rather than the translated version of the
  current page.

### Style‑specific and extra options

Depending on the output type you chose, extra option groups appear:

- **msDropdown** — visible rows, rounded corners, animation, trigger event, and skin.
- **Chosen** — whether to show the search box (off by default for short language lists) and
  the "no results" text.
- **ddSlick** — height, whether the selected item shows its HTML, image position, and skin.
- **Language icons** — when the *Language Icons* module is installed, choose whether the flag
  appears **before** or **after** the language name (after by default).
- **Hidden languages** — hide specific languages from the dropdown for specific roles.

## Save and verify

Click **Save block**. Visit the site as a visitor (or in a private window) on a multilingual
page — the dropdown should appear in the region you chose. Picking a language switches the
site according to your core **language detection** settings; if switching doesn't seem to
take effect, check **Configuration → Regional and language → Languages → Detection and
selection** (`/admin/config/regional/language/detection`).

You can place the block more than once — for example a native‑name selector in the header and
a code‑only selector in the footer — each with its own settings.
