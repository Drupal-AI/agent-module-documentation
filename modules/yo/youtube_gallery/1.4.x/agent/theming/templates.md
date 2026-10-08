# Youtube Gallery — templates, block, routes & service

## Theme hooks (`youtube_gallery_theme`)

| Hook | Template | Variables |
|---|---|---|
| `youtube_gallery` | `templates/youtube-gallery.html.twig` | `content` (all fetched videos), `currentVideo` (selected video: `videoId`, `title`, `description`, `publishedAt`) |
| `youtube_gallery_block` | `templates/youtube-gallery-block.html.twig` | `youtube_content` (array of `video_id`, `video_title`, `thumbnail`, `duration`, `url`) |

Override either template by copying it into your theme. Values are rendered through Twig (auto-escaped).

The module attaches its `youtube_gallery/global-styling` asset library (jQuery, drupal.ajax, once,
`css/style.css`) on every page via `youtube_gallery_page_attachments()`, and provides a
`youtube-gallery` page template suggestion for `/youtube-gallery/*` paths.

## Block

`\Drupal\youtube_gallery\Plugin\Block\YoutubeVideoGallery` — block id `youtube_gallery_block`,
admin label "Youtube Gallery". Iterates the first `max_videos` playlist items, building thumbnail /
title / duration / link (`/youtube-gallery/<videoId>`) rows for the `youtube_gallery_block` theme.
Renders a "Videos rendering faild...!!!" message if the API returns nothing. Place it via Block Layout.

## Routes

| Route | Path | Access | Purpose |
|---|---|---|---|
| `youtube_gallery.manage` | `/admin/config/youtube_gallery/manage` | `administer youtube_gallery` | Status overview + settings form (`YoutubeGallery::youtubeStatus`). |
| `youtube_gallery.config` | `/admin/config/youtube_gallery/config` | `administer youtube_gallery` | Settings form. |
| `youtube_gallery.upload_video` | `/admin/config/youtube_gallery/upload-video` | `administer youtube_gallery` | OAuth upload form. |
| `youtube_gallery.youtube_gallery_page` | `/youtube-gallery/{vid}` | `access content` | Plays a single video (`PlayVideo::content`). |

## Service `youtube_gallery.content` (`YoutubeConfig`)

Public helpers usable from custom code:
`getGoogleApi()`, `getYoutubeVideos()` (decoded playlist items, optionally date-sorted),
`getTotalVideos()`, `getApiKey()`, `getChannelId()`, `getMaxVideos()`, `getChannelTitle()`,
`getVideoDuration($videoId)`, `getCurrentVideo($videoId)`, `getClientId()`, `getClientSecret()`.
All string outputs are passed through `Html::escape()`. Also `youtube_gallery.do_upload`
(`UploadVideo`) drives the OAuth upload.
