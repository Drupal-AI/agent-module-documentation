# Configure CKEditor Accordion

## Enable the Accordion button on a text format

The button is a CKEditor 5 toolbar item, enabled **per text format**:

1. Go to **Admin → Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Edit a format that uses CKEditor 5 (usually **Basic HTML**).
3. Drag the **Accordion** button from *Available buttons* onto the *Active toolbar*.
4. Save.

Plugin definition lives in `ckeditor_accordion.ckeditor5.yml`:

- CKEditor 5 plugin: `accordion.Accordion` (toolbar item id `Accordion`, label "Accordion").
- In-editor balloon **content toolbar**: `accordionAddAbove`, `accordionAddBelow`,
  `accordionRemove` (add a row above/below, remove a row).
- Editor libraries: `ckeditor_accordion/accordion` (+ `accordion.admin` styles).

## Allowed HTML tags

The accordion serializes to a description list, so the format's **Limit allowed HTML tags**
must permit these (declared as the plugin's `elements`):

```
<dl> <dl class> <dt> <dd>
```

Without `<dl class>` the `ckeditor-accordion` class is stripped and the frontend behavior
will not attach.

## Global display settings

Form at `/admin/config/content/ckeditor-accordion` (route `ckeditor_accordion.settings`,
menu link under *Content authoring*). Gated by permission **`administer ckeditor accordion`**
(`restrict access: TRUE`). Values are stored in the `ckeditor_accordion.settings` config
object and passed to the front end via `drupalSettings.ckeditorAccordion.accordionStyle`.
There is **no config schema and no default config** — keys exist only after the form is saved.

| Config key | Form label | Default | Effect |
|---|---|---|---|
| `collapse_all` | Collapse all tabs by default | `0` | Start with every row closed (else first row opens) |
| `keep_rows_open` | Keep accordion rows open when opening another one | `0` | Multi-open; otherwise opening a row closes the others |
| `animate_accordion_toggle` | Animate accordion open / close | `1` | Slide animation on toggle (set 0 for instant) |
| `open_tabs_with_hash` | Open tabs with hash / anchor links | `0` | Hash row titles so `#RowTitle` anchors open a row |
| `allow_html_in_titles` | Allow HTML in row titles | `0` | Permit icons/markup inside `<dt>` titles |

Set from Drush, e.g.:

```
drush cset ckeditor_accordion.settings collapse_all 1
drush cset ckeditor_accordion.settings keep_rows_open 1
```

`ckeditor_accordion_update_2001()` backfills `animate_accordion_toggle` = 1 for sites
upgrading from older versions.

## CKEditor 4 → 5 upgrade

`src/Plugin/CKEditor4To5Upgrade/Accordion.php` maps the legacy CKEditor 4 `Accordion`
button to the CKEditor 5 `Accordion` toolbar item, so existing formats convert automatically
on upgrade. (The old CKEditor 4 plugin `Plugin/CKEditorPlugin/CKEditorAccordion.php` remains
for CKEditor 4 only.)
