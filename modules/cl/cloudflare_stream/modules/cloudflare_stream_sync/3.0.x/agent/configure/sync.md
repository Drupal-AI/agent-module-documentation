# Configure & run the sync

## Prerequisites
- Parent `cloudflare_stream` enabled and configured with a valid API token + account id.
- A Media type whose source plugin is `cloudflare_stream` (the form's *Select Media Type* only lists
  media types matching `source = cloudflare_stream`).

## Form — `/admin/config/media/cloudflare-stream/sync`
Route `cloudflare_stream_sync.sync`, permission `sync cloudflare stream videos`. Pick the target Media
type and press **Sync videos**. The chosen type is saved to `cloudflare_stream_sync.settings:media_type_id`,
then a Batch is built with one operation per fetched video (`SyncVideos::syncVideoCallback`).

## Config object `cloudflare_stream_sync.settings`
| Key | Meaning |
|---|---|
| `media_type_id` | Target Cloudflare-backed media type id. |
| `last_imported` | Unix timestamp of the last successful sync; used as the API `after` filter so later runs import only newer videos. Updated in the batch finish callback / after `syncVideos()`. |

## What happens per video (`SyncVideos::processVideo`)
1. `fetchVideos()` → `cloudflare_stream.api::listVideos($date)` where `$date` is derived from
   `last_imported` (null on first run → import all).
2. Dedup: `checkIfVideoIdExists()` queries media for `<source_field>.cloudflareStreamVideoID == uid`
   (`accessCheck(FALSE)`). If it exists, skip.
3. Else: sanitize the Cloudflare `meta.name` into a filename, `file.repository->writeData('', 'public://'.$filename)`
   to create an empty placeholder file, then `Media::create()` of the chosen bundle owned by the
   current user, published, with the source field set to `{target_id: file, cloudflareStreamVideoID: uid,
   thumbnail: <thumb>}`; save; register file usage; mark the file permanent.

Note the created local file is an empty placeholder — playback still comes from Cloudflare via the
stored video id.
