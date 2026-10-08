# Browser update — configuration

- **Route / form:** `bu.admin_settings` → `/admin/config/system/browser-update`, form
  `\Drupal\bu\Form\SettingsForm` (a `ConfigFormBase` editing `bu.settings`). Permission:
  core `administer site configuration`.
- **Defaults:** `config/install/bu.settings.yml`. **Schema:** `config/schema/bu.schema.yml`
  (`bu.settings`, type `config_object`).

## Settings keys (`bu.settings`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `notify_ie` | float | `-5` | IE/Edge threshold. `-N` = "more than N versions behind"; `-0.01` = every outdated version. |
| `notify_firefox` | float | `-4` | Firefox threshold (same scale). |
| `notify_opera` | float | `-4` | Opera threshold. |
| `notify_safari` | float | `-2` | Safari threshold. |
| `notify_chrome` | float | `-4` | Chrome threshold. |
| `insecure` | bool | `true` | Also notify any version with severe known security issues. |
| `unsupported` | bool | `false` | Also notify browsers no longer vendor-supported. |
| `mobile` | bool | `true` | Also notify mobile browsers. |
| `position` | string | `top` | Message position: `top`, `bottom`, `corner`. |
| `visibility_type` | string | `hide` | `show` = only listed pages; `hide` = everywhere except listed pages. |
| `visibility_pages` | string | `admin/*` | Newline path list; `*` wildcard, `<front>` for front page. |
| `test_mode` | bool | `false` | Force the message on all pages (bypasses visibility). |
| `new_window` | bool | `true` | Open the update link in a new window. |
| `no_close` | bool | `false` | Hide the "Ignore" button. |
| `source` | uri | *(unset)* | Override base script URL. Empty → `//browser-update.org/update.min.js`. |
| `show_source` | uri | *(unset)* | Override the "show message" script URL (default `//browser-update.org/update.show.min.js`). |
| `text_override` | string | *(unset)* | Custom message template; placeholders `{brow_name}`, `{up_but}`, `{ignore_but}`. |
| `reminder` | int | *(unset)* | Hours before the message reappears (0 = always show). |
| `reminder_closed` | int | *(unset)* | Hours before it reappears after the user closes it. |
| `url` | uri | *(unset)* | Destination when the user clicks the notification. |

(The `SettingsForm` groups these under *Browser Versions*, *Visibility*, *Additional Settings*,
and a top-level *Test Mode* checkbox. `validateForm()` is empty.)

## Runtime behavior (`hook_page_attachments`)

1. Load `bu.settings`; if `source` empty, default it to `//browser-update.org/update.min.js`.
2. If `test_mode` is off and `visibility_pages` is set, match the current path: return early
   (no attach) when `visibility_type == 'hide'` and it matches, or `'show'` and it does not.
3. Otherwise attach library `bu/bu.checker` and `drupalSettings.bu = <all settings>`.

`js/bu.js` forwards `drupalSettings.bu` to the remote browser-update.org script, which performs
the browser sniffing and renders the notice client-side.

## Drush

None. Set values with `drush config:set bu.settings <key> <value>` or a config import.
