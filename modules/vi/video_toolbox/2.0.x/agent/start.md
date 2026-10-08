<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Video ToolBox (video_toolbox) — agent index

Upload / manage / play / download videos. Version **2.0.1**. Config at
`/admin/config/media/video_toolbox` (perm `administer video_toolbox`).

- **Routes**: upload `/upload_video` (`upload_content_videos`), report `reports/uploaded_videos`
  (`view_videos_report_list`), edit `/video/{video_id}/edit` (`_role: authenticated`), download
  `/video/download/{identifier}/{type}` (`_role: authenticated`), autocomplete endpoints
  (`access content`).
- **Field/UI**: `video_toolbox_item` field type + `video_player`/`video_input` render elements, a
  `VideoBlock`, and `video_toolbox_styles` config entities for aspect ratios.
