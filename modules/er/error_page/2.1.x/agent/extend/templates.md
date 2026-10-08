# Customizing the error page output

The rendered page is a **plain HTML file with token replacement** — not a Twig template and
not a theme hook. There is nothing to subclass; you customize by copying two files.

## The two templates

Shipped in the module's `markup/` directory:

- `markup/error_page.html` — full HTML document rendered for uncaught exceptions / fatal
  errors (the 500 page).
- `markup/error_message.html` — inline fragment shown as a status message for non-fatal user
  errors.

## Tokens (only these three)

- `{{ uuid }}` — the incident UUID, or empty if `uuid` setting is FALSE.
- `{{ base_path }}` — result of `base_path()`, for building asset URLs (logo, CSS).
- `{{ error_report }}` — technical message + backtrace. **Empty** unless the site's error
  reporting verbosity permits showing details, so it is safe to leave in a production page.

## How to override

1. Copy `error_page.html` and/or `error_message.html` to a directory, ideally **outside the
   web root** (or protected — the module ships `markup/.htaccess`).
2. Point settings at it:

   ```php
   $settings['error_page']['template_dir'] = DRUPAL_ROOT . '/../templates/error_page';
   ```

3. Edit freely — add markup, a logo via `<img src="{{ base_path }}themes/mytheme/logo.png">`,
   inline CSS, etc. Keep the tokens you want; unused tokens are simply replaced with their
   (possibly empty) values.

If `template_dir` is set but a given file is missing there, the module falls back to its own
`markup/` copy for that file, so you can override just one of the two.

Do **not** rely on Drupal render arrays, Twig filters, or `#theme` here — output is produced
by `ErrorPageRenderer::render()` via `strtr()` precisely because Drupal's rendering stack may
be unavailable at crash time.
