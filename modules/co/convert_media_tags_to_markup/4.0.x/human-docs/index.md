# Convert Media Tags to Markup — manual setup guide

**Convert Media Tags to Markup** (`convert_media_tags_to_markup`) cleans up the
leftover media embed tokens that a Drupal 7 → 10/11 migration tends to strand in
your body fields. In Drupal 7 the *Media* module stored embeds as JSON blobs like
`[[{"type":"media","fid":"123",...}]]`. After migrating, those blobs sit in the
text unrendered, so images appear as raw gibberish. This module turns each token
back into a real `<img>` tag pointing at the referenced file.

You can apply the fix in two ways. The **text filter** ("Convert Legacy Media Tags
to Markup") rewrites the tokens on the way out, every time the content is rendered —
add it to a text format and you are done, no re-import needed. Alternatively, a
one-time **database conversion** (run through Drush) rewrites the stored field
values permanently, so you can then remove the runtime filter entirely. The
permanent path has a simulate mode so you can preview every change before committing
it.

The module is intentionally tiny: no admin settings page, no permissions, no
config schema, and no dependencies beyond Drupal core's `file` and `filter`. For
each token it loads the file by its `fid`, builds the image URL, and emits a fixed
`<div class="media …"><img …></div>` wrapper carrying the original `alt`, `title`,
`class`, `style`, `width`, and `height`. A token whose file is missing is logged and
dropped rather than left broken.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no admin menu item and no settings form. You use the module in one of two
ways.

### Option A — the runtime text filter

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a format such as *Full HTML*
   (`/admin/config/content/formats/manage/full_html`).
2. Tick **"Convert Legacy Media Tags to Markup"** and save.
3. Any content in that format now renders its old media tokens as images.

The filter has no settings of its own. Because it is an *irreversible transform*
(it rewrites output and cannot undo it), order it sensibly relative to your other
filters — and keep a **"Limit allowed HTML tags and correct faulty HTML"** filter
running after it to sanitize the result.

### Option B — permanent one-time conversion (Drush)

The module registers no Drush command; instead it exposes a code entry point you
invoke with `drush ev`. **Back up your database first**, and enable *Create new
revision* on the bundle so you can revert per node.

Always simulate first (the trailing `TRUE` prints intended changes and saves
nothing):

```bash
drush ev "\Drupal\convert_media_tags_to_markup\ConvertMediaTagsToMarkup\DbReplacer::instance()->replaceAll('node', 'page', TRUE);"
```

Review the output, then run it for real (trailing `FALSE` saves the entities):

```bash
drush ev "\Drupal\convert_media_tags_to_markup\ConvertMediaTagsToMarkup\DbReplacer::instance()->replaceAll('node', 'page', FALSE);"
```

The signature is `replaceAll(string $type, string $bundle, bool $simulate = TRUE)`.
It loads every entity of that type and bundle, runs each formatted long-text field
value through the same conversion, and either prints the would-be result (simulate)
or saves it (live). Errors are logged per entity. Once conversion is done you can
turn the runtime filter off and remove the module.

> **Using DDEV?** Prefix Drush with `ddev` when running from your host machine —
> `ddev drush ev "…"`.
