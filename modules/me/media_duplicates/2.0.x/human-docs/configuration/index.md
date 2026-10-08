# Configuration

Media Duplicates starts in **detection‑only** mode: as soon as it's enabled it
fingerprints media and can report duplicates, but it won't block anything until you
turn enforcement on. This page covers the settings form, the report, rebuilding
checksums, and the permission that gates it all.

## The settings form

1. Log in as a user with the **Administer media duplicates** permission.
2. Go to **Configuration → Media → Media Duplicates**
   (`/admin/config/media/media-duplicates`).

On a freshly enabled site none of these are switched on (nothing is restricted
until you save the form):

- **Restrict duplicates** — the master switch. When on, saving a media item whose
  fingerprint already exists is **blocked**; the editor sees an error listing the
  conflicting media (with edit links). The two settings below only appear once this
  is enabled.
- **Restrict new media only** — when restricting, block only **new** media. Media
  items that already exist can still be saved even if they have a duplicate
  fingerprint. Useful when you have pre‑existing duplicates you don't want to break.
- **Compare within bundle only** — treat two items as duplicates only when they are
  the **same media type** (bundle). Leave off to catch identical files across
  different media types too.

Click **Save configuration** to apply. The block is enforced as an entity
validation constraint, so it applies both on the media forms and on programmatic
(API) saves.

You can also read or set these from the command line:

```bash
drush config:get media_duplicates.settings
drush config:set media_duplicates.settings restrict_duplicates true -y
drush config:set media_duplicates.settings restrict_new_media_only true -y
drush config:set media_duplicates.settings compare_within_bundle_only true -y
```

### A suggested rollout

Because enforcement is opt‑in, you can introduce it gently: run **report‑only**
first to see what duplicates exist, then turn on **Restrict duplicates** together
with **Restrict new media only** so you stop new duplicates without breaking edits
to existing ones, and finally drop the "new only" restriction once the library is
clean.

## The duplicates report

Go to **Reports → Media duplicates** (`/admin/reports/media-duplicates`) — this
needs the standard **Access site reports** permission. It lists every fingerprint
shared by more than one media entity, with the individual items linked so you can
review and consolidate them. "Rebuild checksums" and "Settings" action links appear
on the page.

## Rebuild checksums for existing media

New media is fingerprinted automatically on save, but media that existed before you
installed the module needs a one‑time rebuild. Two ways:

- **UI:** the **Rebuild checksums** batch at
  `/admin/config/media/media-duplicates/refresh` (needs **Administer media
  duplicates**).
- **Drush:** the `media-duplicates:checksums:rebuild` command:

  ```bash
  # All media types:
  drush media-duplicates:checksums:rebuild all

  # Specific bundles:
  drush media-duplicates:checksums:rebuild image video
  ```

  If you omit the bundle argument, Drush prompts you to pick a media type (or All).
  Run a rebuild after installing on a site with existing media, after changing
  checksum algorithms, or after adding a custom checksum plugin.

Until checksums are rebuilt, the status report warns about media items missing a
fingerprint.

## Permission

- **Administer media duplicates** (`administer media duplicates`) — *"Administer
  media duplication settings and allow rebuilding checksums."* This restricted
  permission gates both the settings form and the rebuild page. The report itself
  uses the separate **Access site reports** permission.

Grant it at **People → Permissions** (`/admin/people/permissions`).

## Supporting more media types (for developers)

The two built‑in checksum plugins cover file‑based and oEmbed sources. To fingerprint
a media source they don't handle, a developer can implement a
`MediaDuplicatesChecksum` plugin, or map a new media type onto an existing plugin
with `hook_media_duplicates_checksum_info_alter()`. See the agent docs at
[`agent/plugins/checksum.md`](../agent/plugins/checksum.md) and
[`agent/hooks/info-alter.md`](../agent/hooks/info-alter.md).
