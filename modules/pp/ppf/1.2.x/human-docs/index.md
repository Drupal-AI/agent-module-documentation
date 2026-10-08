# Preprocessor Files — manual setup guide

**Preprocessor Files** (`ppf`) lets you move Drupal template preprocessing out of
one enormous `THEME.theme` (or `MODULE.module`) file and into small, dedicated
files — one per template. Instead of writing a `hook_preprocess_HOOK()` function
for every template you want to touch, you create a file such as
`node.preprocess.php` or `node--article.preprocess.php` inside your theme, alter
the `$variables` there, and the module runs it exactly as if it were a preprocess
hook.

Under the hood the module scans your active theme, its base themes, and enabled
modules for files matching a configured extension (default `.preprocess.php`)
under a configured folder (default `preprocessors/`). Each file it finds is mapped
to a theme hook by its filename — dashes become underscores, so
`node--article.preprocess.php` targets the `node__article` template suggestion —
and is included during rendering with `$variables`, `$hook`, and `$info` in scope.
Your code runs *after* any traditional preprocess hooks for the same template.

The goal is purely organizational: keep a large project's theme logic readable by
giving each template its own file, kept under version control, instead of a
monolithic theme file everyone is afraid to touch. One thing worth knowing up
front — these are executable `.php` files loaded from your theme or module
directories, so they carry the same trust level as a `.theme` file or a template.
Anyone who can write those files can run arbitrary PHP; there is no web-facing way
to trigger them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form: the file
   extension, the folder name, and generating a starter folder.

## Where it lives in the admin menu

Once enabled, the module's settings form sits at **Configuration → Preprocessor
Files** (`/admin/config/ppf`), reachable by any user with the **Administer site
configuration** permission.

## How to use it

1. In your theme, create a `preprocessors/` folder (or let the settings form
   generate one for you — see [Configuration](configuration/index.md)).
2. Add a file named after the template you want to preprocess, for example
   `preprocessors/node.preprocess.php` for the `node` template, or
   `preprocessors/node--article.preprocess.php` for the article suggestion.
3. Inside that file, alter the variables just as you would in a hook — for
   example `$variables['foo'] = 'bar';`. In `node.html.twig` you can now output
   `{{ foo }}`.

The variables `$variables`, `$hook`, and `$info` are all available in the file,
and your code runs after core's and contrib's traditional preprocess hooks.
Subfolders are allowed (discovery mirrors template discovery), and base-theme
files are inherited by sub-themes.
