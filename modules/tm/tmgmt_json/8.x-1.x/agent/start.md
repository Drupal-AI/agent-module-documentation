<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TMGMT Export / Import JSON (tmgmt_json) — agent index

TMGMT **file translator**: exports job source data to **JSON**, imports translated JSON back. Version **8.x-1.1**. Core `^8 || ^9 || ^10`. Depends on tmgmt_file.

Plugin extends tmgmt_file format base; on import reads the uploaded managed file via `file_get_contents` + `json_decode` (JSON only — no XML/XXE surface) and maps strings onto job data items. No remote API, no routes. Import is done by an authorised TMGMT user through the job UI.
