<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# campaign_monitor_webform — agent orientation

- Webform handler plugin `src/Plugin/WebformHandler/WebformCampaignMonitorHandler.php` that subscribes submitters to Campaign Monitor.
- Depends on `campaign_monitor_rest_client` (holds API key + performs the HTTP/TLS) and `webform`. This module does no direct cURL.
- Sends payload to `subscribers/<listID>.json` on `preSave`; hardcodes ConsentToTrack=Yes.
- Security note (low): logs full API response via `print_r` at info level → possible PII in logs. TLS/key handling is in the REST client dependency, out of this module's scope.
- No routes/permissions of its own.
