# Puphpeteer settings (`puphpeteer.settings`)

Form `Drupal\puphpeteer\Form\Configuration`, route `puphpeteer.config` at
`/admin/config/system/pdf-api/puphpeteer` (permission `administer site configuration`).
Values persist to the **`puphpeteer.settings`** config object, read by the `puphpeteer`
generator plugin.

> The module is normally disabled here (needs Node + Puppeteer). The `puphpeteer.settings`
> config object can still be created and read with drush even while the module is disabled,
> but the settings only take effect once puphpeteer is enabled and Node/Chromium is present.

## Config keys (`puphpeteer.settings`)

| Key | Type | Install default | Meaning |
|---|---|---|---|
| `executable_path` | string | `''` | Path to the Node executable (blank = default). |
| `chrome_extra_args` | string | `''` | Extra flags passed to Chrome (e.g. `--no-sandbox`). |
| `idle_timeout` | int | `5` | Idle timeout (seconds). |
| `read_timeout` | int | `5` | Read timeout (seconds). |
| `stop_timeout` | int | `5` | Stop timeout (seconds). |
| `log_to_node_console` | bool | `false` | Log to the Node console. |
| `debug` | bool | `false` | Enable debugging support. |
| `log_to_browser_console` | bool | `false` | Log to the browser console. |
| `headless` | bool | `true` | Run Chrome headless (usually yes). |
| `triggerDebugging` | bool | `false` | Trigger the debugger via `page.evaluate`. |
| `devTools` | bool | `false` | Open devtools. |
| `slowMo` | int | `0` | Delay added to Puppeteer actions (ms). |
| `source` | string | `printable` | Content source used to build the PDF. |
| `pagedjs` | bool | `false` | Load paged.js in Chrome for print pagination. |
| `service` | bool | `false` | Connect to an external Puppeteer service instead of launching one. |
| `service_url` | string | `''` | `browserURL` to connect to (see `puppeteer.connect`). |
| `leave_running` | bool | `true` | Leave the browser running after use. |
| `basic_auth_username` | string | `''` | Username for HTTP basic auth. |
| `basic_auth_password` | string | `''` | Password for HTTP basic auth. |

(The schema also declares `printBackground` — print CSS backgrounds.)

## Read / write with drush

```bash
drush cget puphpeteer.settings
drush cget puphpeteer.settings executable_path
drush cset -y puphpeteer.settings executable_path /usr/bin/node
drush cset -y puphpeteer.settings pagedjs 1
drush cset -y puphpeteer.settings service 1
drush cset -y puphpeteer.settings service_url http://chrome:9222
```

```php
\Drupal::configFactory()->getEditable('puphpeteer.settings')
  ->set('headless', FALSE)
  ->set('devTools', TRUE)
  ->save();
```

The `puphpeteer` backend itself is a pdf_api `PdfGenerator` plugin — load and drive it exactly
like any other backend (`plugin.manager.pdf_generator`); see
[pdf_api generate-pdf](../../../../2.4.x/agent/api/generate-pdf.md).
