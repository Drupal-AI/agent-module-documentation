<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reverso Translator — setup

## Add the translator
1. Go to **Configuration → Regional and language → Translation Management Translators** (`/admin/tmgmt/translators`).
2. **Add translator**, select **Reverso** as the plugin.
3. Settings:
   - **Username** — Reverso API username.
   - **Password** — Reverso API password (masked; leave empty to keep current). Used only as the HMAC-SHA1 signing key, not sent directly.
   - **Url** — endpoint base, e.g. `https://api.reverso.net`. Use HTTPS.
4. Save, then adjust **Remote languages mappings** if the defaults don't match your languages.

## How requests are built (`ReversoTranslator`)
- Auth headers: `Created` = RFC date, `Username`, `Signature = hash_hmac('sha1', username.date, password)`.
- Language codes mapped via `$mappingLanguages` (ISO 639-1 → 639-2/B).
- Per string: HTML (detected when `strip_tags` changes the text) → `POST {url}/v1/TranslateStream/direction={src}-{tgt}/inputExtension=html` (response `TranslatedStream` is base64-decoded); plain → `POST {url}/v1/TranslateText/direction={src}-{tgt}`.
- Errors raise `TMGMTException` and reject the job.

## Use
On a translatable entity's **Translate** tab, pick target language(s), choose **Reverso**, submit. Continuous jobs remain open (not auto-finished).
