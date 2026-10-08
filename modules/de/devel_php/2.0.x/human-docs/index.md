# Devel PHP — manual setup guide

**Devel PHP** (`devel_php`) adds an "Execute PHP" page and block to the
[Devel](https://www.drupal.org/project/devel) module, letting a trusted developer run
arbitrary PHP code straight from the admin UI. It is the successor to the PHP-execute
feature that used to ship inside Devel itself. You paste a snippet, click **Execute**,
and the code runs against your live site — handy for one-off debugging, inspecting an
entity, calling a service, or prototyping an update-hook body without writing a module
or a Drush script.

The page lives at `/devel/php` (also linked in the Devel menu). Whatever your code
**prints** is captured and shown through Devel's dumper (Kint or var-dumper, per your
Devel settings), so structured data displays readably — note that a `return`ed value
is *not* dumped, so `print` or `echo` what you want to see. Any error thrown is caught
and shown as a message. Your last snippet is remembered for the session and
re-populated into the textarea, so you can tweak and re-run. Do **not** wrap your code
in `<?php ?>` tags. The same form is also available as a placeable block ("Execute
PHP Code") if you want it embedded in a dashboard.

> **This is a development-only tool.** Running arbitrary PHP through `eval()` on the
> server is equivalent to full site and server compromise. Its single permission is
> flagged security-sensitive, has no finer-grained variants, and should be granted
> **only** to a single trusted developer role — and **never** on production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (Devel is required).

## Where it lives in the admin menu

There is no settings form. The feature is the **Execute PHP** page at `/devel/php`,
reachable from the **Devel** menu. Access is gated entirely by the single **Execute
php code** (`execute php code`) permission, set at **People → Permissions**
(`/admin/people/permissions`). The optional "Execute PHP Code" block is placed from
**Structure → Block layout** and enforces the same permission.

## How to use it

1. Enable the module and grant **Execute php code** to a single trusted developer
   role on a non-production environment.
2. Go to `/devel/php` (or the Devel menu → Execute PHP).
3. Paste raw PHP (no `<?php ?>` tags) and click **Execute**. `print` or `echo` the
   values you want to see so they flow through Devel's dumper.

For example, to inspect a node's label:

```php
$node = \Drupal::entityTypeManager()->getStorage('node')->load(1);
print $node->label();
```

To embed the form elsewhere on a non-production site, place the **Execute PHP Code**
block in a region from the Block layout page.
