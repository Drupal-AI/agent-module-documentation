# Permissions

| Permission | Machine name | Grants |
|-----------|--------------|--------|
| Permit access to using the OpenAI prompt. | `access openai prompt` | Access `/admin/config/openai/openai-prompt` and submit prompts to OpenAI's completions endpoint (each submit is a billed API call against the site's key). |

Defined in `openai_prompt.permissions.yml`; the only requirement on the `openai_prompt.prompt_form`
route.

    drush role:perm:add editor 'access openai prompt'
