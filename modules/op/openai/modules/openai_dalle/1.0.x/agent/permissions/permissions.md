# Permissions

| Permission | Machine name | Grants |
|-----------|--------------|--------|
| Use OpenAI DALL·E | `access openai dalle` | Access `/admin/config/openai/dalle` and submit prompts to the DALL·E image endpoint (each submit is a billed OpenAI API call against the site's key). |

Defined in `openai_dalle.permissions.yml`. It is the only requirement on the
`openai_dalle.dalle_form` route. Grant via UI (People → Permissions) or:

    drush role:perm:add editor 'access openai dalle'
