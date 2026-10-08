# devel_php — Execute PHP

There is **no settings form** and no config entity (`info.yml` has no `configure` key,
no `config/schema`). "Configuration" here means where the feature lives and how it behaves.

## The page

- Route `devel_php.execute_php` → path **`/devel/php`** (`_admin_route: TRUE`).
- Menu link `devel_php.execute_php` ("Execute PHP") in the **`devel`** menu.
- Form class `\Drupal\devel_php\Form\ExecutePHP` (form id `devel_execute_form`).
- A `details` element "PHP code to execute" contains a 20-row monospace textarea and an
  **Execute** submit button.
- Enter raw PHP — **do not** wrap it in `<?php ?>` tags.

## Behavior (from `ExecutePHP::submitForm`)

- The submitted code is run with `eval($code)` inside `ob_start()`/`ob_get_clean()`.
- Whatever the code **prints** is captured and shown via Devel's dumper
  (`$this->develDumper->message(...)`, the `devel.dumper` service — respects Devel's
  configured backend like Kint/var-dumper). A `return`ed value is not dumped; `print`/`echo`
  what you want to see, or dump it yourself.
- Any thrown `\Throwable` is caught and shown as an error message (`messenger()->addError()`).
- The last snippet is saved in the session key `devel_execute_code` and repopulated into the
  textarea on the next render (so you can edit and re-run); it is removed from the session
  after being read once.

## The block

- Block plugin id **`devel_execute_php`**, admin label "Execute PHP Code"
  (`\Drupal\devel_php\Plugin\Block\DevelExecutePHP`).
- Renders the same `ExecutePHP` form (built with arg `FALSE`, so the details element starts
  collapsed when there is no stored code).
- `blockAccess()` requires the `execute php code` permission — same gate as the page.
- Place it like any block (Block Layout UI or a section) on a non-production environment.

## Services parameter

`devel_php.services.yml` sets `devel_php.skip_procedural_hook_scan: true` (tells Devel's
hook scanner to skip this module — no functional config to change).
