# Drush: `rrssb:gen-css`

One command, provided by `Drupal\rrssb\Drush\Commands\RrssbCommands`.

| Command | Alias | Purpose |
|---|---|---|
| `rrssb:gen-css` | `rrssb-gen-css` | Regenerate `css/rrssb.buttons.css` inside the RRSSB+ library from the current button configuration. |

```bash
drush rrssb:gen-css
```

It builds the per-button CSS via `rrssb_calc_css(rrssb_button_config())` and writes it to
`rrssb_library_path() . '/css/rrssb.buttons.css'`. Run it after you add or alter buttons
(`hook_rrssb_buttons()` / `_alter`) or change button colours, so the generated CSS matches. The
command takes no arguments or options.
