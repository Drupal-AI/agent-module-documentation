<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the X-Frame-Options header

## The directive

Config object **`x_frame_options_configuration.settings`**. The form stores its values under a
**nested** key (the form calls `->set('x_frame_options_configuration.directive', …)`), so the
actual structure is:

```yaml
x_frame_options_configuration:
  directive: SAMEORIGIN          # DENY | SAMEORIGIN | ALLOW-FROM | ALLOW-ALL
  allow-from-uri: ''             # used only when directive is ALLOW-FROM
```

Directive meanings (set by `XframeSubscriber::onKernelResponse`, RESPONSE priority -20):

| Directive | Resulting header |
|---|---|
| `DENY` | `X-Frame-Options: DENY` — never framable. |
| `SAMEORIGIN` | `X-Frame-Options: SAMEORIGIN` — same-origin framing only. |
| `ALLOW-FROM` | `X-Frame-Options: ALLOW-FROM <allow-from-uri>` (URI is passed through `UrlHelper::stripDangerousProtocols`). Obsolete in modern Chromium/Safari. |
| `ALLOW-ALL` | The header is **removed** from the response. |

There is **no config schema and no default config**. Until the form is saved once, the config
object is empty and the subscriber falls back to `directive ?? 0`, emitting `X-Frame-Options: 0`.
Save the settings form once to establish a real value.

## Via the UI

1. Go to `admin/config/system/x_frame_options_configuration/settings` (route
   `x_frame_options_configuration.settings`, permission `administer site configuration`).
2. Pick a **Directive** radio. The **Uri** field only appears (via `#states`) when `ALLOW-FROM`
   is selected.
3. Save.

## Via drush (note the nested key)

```bash
# Read:
drush cget x_frame_options_configuration.settings

# Set SAMEORIGIN:
drush php:eval '\Drupal::configFactory()->getEditable("x_frame_options_configuration.settings")
  ->set("x_frame_options_configuration.directive", "SAMEORIGIN")
  ->set("x_frame_options_configuration.allow-from-uri", "")
  ->save();'

# ALLOW-FROM a partner:
drush php:eval '\Drupal::configFactory()->getEditable("x_frame_options_configuration.settings")
  ->set("x_frame_options_configuration.directive", "ALLOW-FROM")
  ->set("x_frame_options_configuration.allow-from-uri", "https://partner.example.com/")
  ->save();'
```

Because the header is set on every response by the subscriber, a config change takes effect on
the next request (dynamic-page cache aside).

## Verify the live header

```bash
curl -sI https://<site>/ | grep -i x-frame-options
```

(Choosing `ALLOW-ALL` means this header will be absent.)
