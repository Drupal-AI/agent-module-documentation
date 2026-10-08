# htmlmail — configure

## Admin routes (from htmlmail.routing.yml)

| Route | Path | Form | Permission |
|---|---|---|---|
| `htmlmail.settings` | `/admin/config/system/htmlmail` | `HtmlMailConfigurationForm` | `administer site configuration` |
| `htmlmail.test` | `/admin/config/system/htmlmail/test` | `HtmlMailTestForm` | `administer site configuration` |

`configure` route in info.yml = `htmlmail.settings`. Menu link under `system.admin_config_system`.

Because it depends on Mail System, the actual routing of which module's mail uses HTML Mail is
done on the Mail System page `/admin/config/system/mailsystem` (not part of this module).

## Config object: `htmlmail.settings`

Default values (config/install/htmlmail.settings.yml) and schema (config/schema/htmlmail.schema.yml):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `debug` | boolean | `false` | Append debugging info (template/theme resolution, params) to the message. |
| `theme` | string | `''` | Machine name of the "Email theme" whose `templates/` dir holds override templates. `''` = no theme (module templates only). Only enabled themes are allowed. |
| `html_with_plain` | boolean | `false` | Provide a plain-text alternative of the HTML mail (form field only shown when `use_mail_mime` is checked). Also acts as a "force plain" gate at format time. |
| `use_mail_mime` | boolean | `false` | Use the PEAR `\Mail_mime` class to assemble MIME (must be installed; validated on save). |
| `postfilter` | string | `'0'` | Text-format id to run over the body **after** theming; `'0'` = Unfiltered. |
| `test` | mapping | see below | Stored defaults for the Send-test form (`to`, `subject`, `body.value`, `class`). |

The `test` mapping default: `to: user@example.com`, `subject: subject test`, `body.value: body test`, `class: test`.

## Set via drush

```bash
drush config:set htmlmail.settings theme olivero -y
drush config:set htmlmail.settings postfilter <format_id> -y   # e.g. a text format machine name
drush config:set htmlmail.settings debug true -y
drush config:get htmlmail.settings
```

## Recommended post-filters (suggested in the UI)

- **Emogrifier** — inline CSS into style attributes for webmail/mobile.
- **Transliteration** — non-ASCII → ASCII (avoids smart-quote artifacts).
- **Pathologic** — rewrite relative URLs to absolute.

## Config history (from htmlmail.install)

- `htmlmail_update_8301` renamed the legacy `htmlmail_*`-prefixed keys to the current names.
- `htmlmail_update_8302` renamed `use_mime_mail` → `use_mail_mime`.
- Install/uninstall hooks flip `system.mail` `interface[htmlmail]` and mailsystem
  `defaults.sender`/`defaults.formatter` between `htmlmail` and `php_mail`.
