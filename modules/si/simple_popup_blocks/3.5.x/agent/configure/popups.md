<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — popups (the `simple_popup_blocks.popup_<uid>` config object)

## Where
- Add form: `/admin/config/media/simple-popup-blocks/add` — route `simple_popup_blocks.add`
  (this is the `configure` route from `.info.yml`), form `SimplePopupBlocksAddForm`.
- Manage list: `/admin/config/media/simple-popup-blocks/manage` — route `simple_popup_blocks.manage`.
- Edit: `…/simple-popup-blocks/manage/{uid}` (route `simple_popup_blocks.edit`).
- Delete: `…/simple-popup-blocks/delete/{uid}` (route `simple_popup_blocks.delete`).
- Permission for all of the above: **`administer simple_popup_blocks`**.

## Storage model
Each popup is a **simple config object**, not a config entity: one object per popup named
`simple_popup_blocks.popup_<uid>` (schema type `config_object`, pattern `simple_popup_blocks.*`).
The `<uid>` is the "Unique identifier" you type, lowercased with every non-`[a-z0-9_]` char
replaced by `_` (e.g. `My Popup!` → `my_popup_`). `hook_page_attachments()` finds popups by
listing config names with the prefix `simple_popup_blocks.popup_`.

## Keys (all in `simple_popup_blocks.popup_<uid>`)
| Key | Type | Default | Meaning |
|---|---|---|---|
| `uid` | string | — | The sanitized unique id; also the suffix of the config name. |
| `type` | int | 0 | **0** = target a Drupal block, **1** = target a custom CSS id/class. |
| `identifier` | string | — | If `type` 0: a block config id (rendered as `block-<id>`, `_`→`-`). If `type` 1: a bare selector name **without** leading `.`/`#`. |
| `css_selector` | int | 1 | Only when `type` 1: **0** = class (`.`), **1** = id (`#`). |
| `layout` | int | 0 | Screen position (see enum below). |
| `trigger_method` | int | 0 | **0** automatic, **1** manual on click, **2** before browser/tab close (see enum). |
| `trigger_selector` | string | '' | Only when `trigger_method` 1: the click target, **must** start with `.` or `#`. |
| `delay` | int | 0 | Only when `trigger_method` 0: seconds to wait after page load. |
| `visit_counts` | text | `a:1:{i:0;s:1:"0";}` | PHP-**serialized** array of visit numbers on which to show (`0` = every visit; `1,2` = 1st & 2nd). |
| `use_time_frequency` | bool | false | If true, throttle by time instead of visit count (then `visit_counts` is forced to `[0]`). |
| `time_frequency` | int | 3600 | Only when `use_time_frequency`: **3600** hourly, **86400** daily, **604800** weekly. |
| `overlay` | bool | true | Dim/overlay the page behind the popup. |
| `enable_escape` | bool | true | ESC key closes the popup. |
| `close` | bool | true | Show a close (×) button. |
| `minimize` | bool | true | Show a minimize button. |
| `show_minimized_button` | bool | false | Show the minimized button when the popup is not auto-triggered. |
| `width` | int | 400 | Popup width in px (invalid/empty → 400). |
| `cookie_expiry` | int | 100 | Days to remember dismissal; **0** = clear when the browser closes. |
| `status` | bool | — | Enabled. Only popups with `status: 1` are attached to pages. |

`trigger_width` exists in the config schema and the add form, but the current add/edit submit
handler does **not** persist it, so it is normally absent from the saved object.

### `layout` enum
`0` top-left · `1` top-right · `2` bottom-left · `3` bottom-right · `4` center ·
`5` top-center · `6` top-bar · `7` bottom-bar · `8` left-bar · `9` right-bar.

### `trigger_method` enum
`0` Automatic (uses `delay`) · `1` Manual — on click of `trigger_selector` · `2` Before browser/tab close.

## Read with drush
```bash
# list every popup config object
drush php:eval 'print_r(\Drupal::service("config.factory")->listAll("simple_popup_blocks.popup_"));'

# dump one popup
drush cget simple_popup_blocks.popup_newsletter
drush cget simple_popup_blocks.popup_newsletter trigger_method
```

## Create / update with drush
The form writes plain config, so you can create a popup entirely from `drush php:eval`. Note
`visit_counts` must be a **serialized** array and `status` must be `1` to render.
```bash
drush php:eval '
  \Drupal::configFactory()->getEditable("simple_popup_blocks.popup_newsletter")
    ->set("uid", "newsletter")
    ->set("identifier", "newsletter-signup")   // custom selector name (no . or #)
    ->set("type", 1)                            // 1 = custom css id/class
    ->set("css_selector", 1)                    // 1 = id (#), 0 = class (.)
    ->set("layout", 4)                          // 4 = center
    ->set("trigger_method", 0)                  // 0 = automatic
    ->set("trigger_selector", "")
    ->set("delay", 3)                           // show after 3s
    ->set("visit_counts", serialize([0 => "0"]))
    ->set("use_time_frequency", FALSE)
    ->set("time_frequency", 3600)
    ->set("overlay", TRUE)
    ->set("enable_escape", TRUE)
    ->set("close", TRUE)
    ->set("minimize", TRUE)
    ->set("show_minimized_button", FALSE)
    ->set("width", 400)
    ->set("cookie_expiry", 100)
    ->set("status", 1)
    ->save();
'
drush cr   # clear caches so the popup is attached (the module reminds you of this)
```

## Delete with drush
```bash
drush php:eval '\Drupal::configFactory()->getEditable("simple_popup_blocks.popup_newsletter")->delete();'
```

## Styling
The module ships **no** popup design. A popup's edit page lists the generated CSS selectors —
parent `#spb-<identifier>`, `.<identifier>-modal`, `.<identifier>-modal-close`,
`.<identifier>-modal-minimize`, `.<identifier>-modal-minimized`, and a position-override
selector like `.<identifier>-modal .spb_center`. Style these in your theme.
