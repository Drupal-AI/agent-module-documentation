<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Voice Search Feature — settings

## Enable & configure
1. Go to **Configuration → System → Voice search** (`/admin/config/system/voice-search`, permission `administer site configuration`).
2. Tick **enable feature**.
3. Adjust the feedback strings (shown while the mic is active):
   - **Speak Now Text** (default "Speak Now")
   - **Listening Text** (default "Listening..")
   - **Did not get, try again Text** (default "Did not get, please try again")
4. Save. `vsf.settings` stores these values.

## How it renders
When `enable_feature` is on, `hook_page_attachments` injects a microphone icon (`images/mic.svg`) and attaches the `vsf/vsf_styles` library. The browser's Web Speech API performs recognition locally. The route `/voice-search-feature/data` (`vsf.search_controller`, `access content`) returns an `AjaxResponse` (`HtmlCommand` into `#voice_search_wrapper`) built from the `vsf` theme template and the configured labels.

## Notes
- No audio or query is sent to the Drupal server for recognition — it happens in the browser.
- The module supplies the input widget; results come from the site's existing search.
