# Error custom pages — manual setup guide

**Error custom pages** (`error_page`) replaces Drupal's bare crash output — the dreaded
"white screen of death" — with a friendly, customizable HTML page whenever an uncaught
exception or a fatal PHP error occurs. Instead of a blank or raw error, visitors see a
branded page you control, and each incident can be tagged with a **UUID** the visitor can
quote to your support team (and that you can grep for in the logs).

The module is deliberately **service-light**. When Drupal crashes hard, its normal
services, configuration system, and Twig may be unavailable — so this module avoids all of
them. It renders a plain HTML file with simple token replacement, and it is configured
entirely through **`settings.php`**, not an admin form. That's a deliberate design choice
that makes it reliable exactly when everything else has failed.

It works in two layers. **Uncaught exceptions** are handled automatically the moment you
enable the module — it swaps in its own 500-page renderer with no configuration needed. To
also catch **fatal and user-level PHP errors**, you register a couple of handlers in
`settings.php`. Either way, you can point the module at your own HTML templates to match
your site's branding.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the `settings.php` options, registering the
   PHP error handlers, and customizing the page markup.

## Where it lives in the admin menu

Error custom pages has **no admin UI** and adds no menu items — there is nothing to click.
All setup happens in code: enabling the module (for exceptions) and editing `settings.php`
(for everything else). See [Configuration](configuration/index.md).

## How to use it

- **For uncaught exceptions:** just enable the module. Its friendly 500 page takes over
  automatically, no configuration required.
- **For fatal/user PHP errors:** additionally register the module's error and exception
  handlers in `settings.php` (see [Configuration](configuration/index.md)).
- **To brand the page:** copy the module's `markup/error_page.html` (and
  `error_message.html`) to your own directory and point `template_dir` at it. The
  templates support the tokens `{{ uuid }}`, `{{ base_path }}`, and `{{ error_report }}`.
