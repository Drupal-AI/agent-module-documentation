# Permissions

| Permission | Machine name | Grants |
|-----------|--------------|--------|
| Permit access to using the OpenAI ChatGPT explorer. | `access openai chatgpt` | Access `/admin/config/openai/chatgpt` and hold a conversation with OpenAI's Chat endpoint (each turn is a billed API call against the site's key). |

Defined in `openai_chatgpt.permissions.yml`; the only requirement on the
`openai_chatgpt.chat_form` route.

    drush role:perm:add editor 'access openai chatgpt'
