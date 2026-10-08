# Permissions

| Permission | Machine name | Grants |
|-----------|--------------|--------|
| Use OpenAI audio | `access openai audio` | Access `/admin/config/openai/audio` and submit an audio file path to OpenAI's Whisper endpoint for transcription/translation (each submit is a billed API call against the site's key). |

Defined in `openai_audio.permissions.yml`; the only requirement on the `openai_audio.audio_form`
route.

    drush role:perm:add editor 'access openai audio'
