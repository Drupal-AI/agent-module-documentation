# Configuration

All of Inline Image Saver's behavior is controlled from a single settings form.
The processing itself runs automatically whenever an entity is saved — this page
is where you decide *which* content it applies to and *how* it handles images.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Content authoring → Inline Image Saver**, or navigate
   directly to `/admin/config/content/inline-image-saver/settings`.

## Processable formats

**Processable formats** lets you restrict the module to specific text formats — for
example only *Full HTML* and *Basic HTML*. Leaving it empty means **all** formats
are processed. This is the switch you use to turn the whole feature on or off for a
given format: a format you don't list here is left untouched.

## Image validation

**Enable validation** (on by default) turns on a set of checks against inline
images. When a checked image fails validation, saving is blocked with an error
(unless downloading is set to handle it). The sub‑options are:

- **Allow if downloadable** — skip validation for external images that can instead
  be downloaded (requires downloading to be enabled).
- **Allow data URI** — let base64 `data:` images pass validation.
- **Check file exists** — verify that the referenced file actually exists on disk.
- **Check file MIME** — verify the image has a valid, supported MIME type.
- **Validate URL** / **Validate URL query** — confirm the image's URL matches the
  file entity's URL, optionally including the query string.

If you want to *hard‑block* external images rather than fetch them, leave
validation on and turn downloading off.

## Image download

**Enable download** (on by default) downloads external images that fail
validation and saves them as local file entities on save. The related option
**Prefer reuse files** reuses an existing file when the content is identical
(matched by hash), which avoids duplicating the same image over and over; the
[File Hash](https://www.drupal.org/project/filehash) module improves this
matching.

## Replace broken images

**Enable replace** (off by default) replaces any image that is still broken —
one that couldn't be validated or downloaded — with your **Fallback markup**. The
fallback is filtered for safety and supports token placeholders such as `@src`,
`@alt`, and `@title`, so you can render, for instance, a caption noting the
original source.

## Revisions

**Create new revision** (on by default) makes the module record a new entity
revision whenever it replaces or downloads an image, and **Revision log** lets you
set the message stored with that revision — useful for auditing what the module
changed and when.

## Skip processing on sync

**Skip processing on sync** (on by default) tells the module to leave entities
alone during programmatic synchronization (anything implementing Drupal's
`SynchronizableInterface`), so config and content imports run cleanly without the
module rewriting image markup mid‑import.

## Save

Click **Save configuration**. Changes apply to the next entity save. (Toggling
validation clears the relevant field‑type caches automatically, so no manual cache
rebuild is needed.)

## For developers: custom MIME detection

MIME detection is extensible. You can register a service tagged
`inline_image_mime_guesser` (with a `priority`) implementing the module's MIME
resolver interface; it will be collected alongside the built‑in fileinfo and
binary resolvers.
