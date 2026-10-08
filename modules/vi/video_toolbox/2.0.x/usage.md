<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Video ToolBox lets authenticated users upload videos (public or private), lists uploaded videos in a report, provides per-video edit/download/delete, a `video_toolbox_item` field type with an HTML5 `video_player` render element, a block, and configurable video-style aspect ratios.

---

The download route `/video/download/{identifier}/{type}` is gated by `_role: 'authenticated'`; `VideoHandler::downloadVideo()` loads a file by the supplied identifier and streams it. The autocomplete routes are gated by `access content`. The edit form (`/video/{video_id}/edit`, `_role: authenticated`) checks ownership/admin before showing edit controls, and private videos are hidden without `view_hidden_content_vt`.

---

- Upload MP4 (or configured) videos through a web form.
- Mark videos public or private on upload or edit.
- List uploaded videos in a per-user report.
- Let admins search videos by uploader username.
- Provide per-video edit, delete and download actions.
- Render videos with a bundled HTML5 player element.
- Add a `video_toolbox_item` video field to content types.
- Define reusable aspect-ratio video styles.
- Place a video block via the block system.
- Import existing `file_managed` MP4 files into the toolbox.
- Store private videos under a private:// folder.
- Gate uploads behind `upload_content_videos`.
- Restrict the report list with `view_videos_report_list`.
- Confirm private-video visibility relies on `view_hidden_content_vt`.
- Review all `_role: authenticated`-only routes before production.
