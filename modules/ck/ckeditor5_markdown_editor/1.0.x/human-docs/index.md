# CKEditor5 Markdown editor — manual setup guide

**CKEditor5 Markdown editor** (`ckeditor5_markdown_editor`) switches a CKEditor 5
text format so it **outputs Markdown instead of HTML**. It activates CKEditor 5's
official *markdown-gfm* plugin, letting authors work in the familiar WYSIWYG while
the stored content is lightweight GitHub-Flavored Markdown — handy for developer
and documentation teams who prefer Markdown as their source of truth.

There's an important wrinkle in how it's installed. The actual CKEditor JavaScript
plugin is a third-party npm asset that is *not* bundled with the module, so the
module ships a Drush command that downloads it into your site's `/libraries`
directory. That means enabling the module is a two-step affair: enable it, then run
the install command (see [Installation](installation/index.md)). Drupal's status
report at `/admin/reports/status` will warn you if the plugin files are missing or
if their version doesn't match your installed CKEditor core version.

Once the assets are in place, each CKEditor 5 text format gains a **Markdown
output** checkbox in its editor settings — tick it to make that format emit
Markdown. The module only changes what the editor *outputs*; it does **not** render
stored Markdown back to HTML when the content is displayed. For that, pair it with
a filter such as [Markdown Easy](https://www.drupal.org/project/markdown_easy) or a
formatter like
[Markdown field formatter](https://www.drupal.org/project/markdown_field_formatter).

It depends on Drupal core's CKEditor 5, runs on Drupal 10 and 11, defines no routes
or permissions of its own, and is not covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   run the Drush command that downloads the editor plugin assets.

There is **no separate settings page**. The only per-format option is the
**Markdown output** checkbox, described below.

## How to use it

After you've enabled the module and downloaded the plugin assets (see the
installation guide):

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Click **Configure** next to a format that uses CKEditor 5.
3. In the CKEditor 5 plugin settings, tick **Markdown output**.
4. Click **Save configuration**.

Content authored in that format is now stored as Markdown. Remember to add a
Markdown-to-HTML filter or formatter (see above) if you want the stored Markdown
rendered as HTML on the front end.
