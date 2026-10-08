# Permissions

| Permission | Machine name | Grants |
|-----------|--------------|--------|
| Use OpenAI text to speech | `access openai tts` | Access `/admin/config/openai/tts` and convert text to audio via OpenAI's TTS endpoint (each submit is a billed API call against the site's key and writes a public file). |

Defined in `openai_tts.permissions.yml`; the only requirement on the `openai_tts.tts_form` route.

    drush role:perm:add editor 'access openai tts'
