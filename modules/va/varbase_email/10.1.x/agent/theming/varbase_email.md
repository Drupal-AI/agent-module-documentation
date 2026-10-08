<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming Varbase Email

The module's only PHP is `src/Hook/VarbaseEmailHooks.php` (an OOP hook class using `#[Hook(...)]`
attributes). It registers the mail theme hook and preprocesses its variables. This is what you
override to change how outgoing HTML mail looks.

## The `email` theme hook

`VarbaseEmailHooks::theme()` (`#[Hook('theme')]`) registers:

```php
$return['email'] = [
  'template'   => 'varbase_emails',                 // templates/varbase_emails.html.twig
  'path'       => $path . '/templates',
  'variables'  => ['email' => NULL],
  'mail theme' => TRUE,                              // rendered with the site's mail theme
];
```

Symfony Mailer renders each message through this `email` theme hook. To override the wrapper markup,
copy `templates/varbase_emails.html.twig` into your theme and adjust it (standard Drupal template
override; clear cache). The template is a table-based responsive HTML shell with a header (logo),
optional heading, a white content card holding `{{ body }}`, and a footer with site name/slogan and a
copyright year.

### Template variables

Set by `preprocess_email()` (`#[Hook('preprocess_email')]`):

| Variable | Source |
|---|---|
| `body` | `$email->getBody()` — the rendered message body |
| `logo` | see logo resolution below |
| `site_name` | `system.site:name` (falls back to "Varbase") |
| `site_slogan` | `system.site:slogan` (falls back to a default tagline) |
| `site_link` | `TRUE` when site config is present (footer links the name to `base_url`) |
| `heading` | passed through from the message variables (`$email->getVariables()`) |

The preprocess also merges `$email->getVariables()` into the template scope, so any variable a
message adds is available in Twig.

## Logo resolution (theme settings)

`preprocess_email()` picks the logo from the **default theme's** settings, in this order:

1. `email_logo_default` truthy → `$host . theme_get_setting('logo.url')` (the site logo).
2. else `email_logo_upload` (a managed file id array) → the uploaded file's URL.
3. else `email_logo_path` (a URI) → absolute URL (via `FileUrlGenerator`; prefixes `$host` when the
   URI has no stream scheme).
4. else → `$host . theme_get_setting('logo.url')`.

`$host` is `\Drupal::request()->getSchemeAndHttpHost()`. The `email_logo_*` settings are provided by
Varbase themes (e.g. Vartheme); on a non-Varbase theme they are absent and case 4 (the site logo)
applies. To customise the mail logo, set those theme settings (or override the template's `{{ logo }}`
usage).

## Style libraries (LTR / RTL)

`varbase_email.libraries.yml` declares two CSS-only libraries:

```yaml
default.email-style.ltr:   # css/theme/email-style.theme.ltr.css
default.email-style.rtl:   # css/theme/email-style.theme.rtl.css
```

`preprocess_email()` attaches the direction-correct one per message:

```php
$email->addLibrary('varbase_email/default.email-style.' . $language->getDirection());
```

So right-to-left languages automatically get the RTL stylesheet. To restyle mail, override these CSS
files (or add your own library and attach it from a custom `hook_preprocess_email`). Note the primary
`.main` card also carries inline styles in the Twig template — many mail clients strip `<style>`, so
per-element inline CSS (the default mailer policy runs `mailer_inline_css`) is what actually renders.
