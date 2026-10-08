# permissions — what AI Core defines and what each gates

From `ai.permissions.yml`. Most administrative ones are `restrict access: true` (grant only
to trusted roles — they expose keys, spend money, or control moderation policy).

| Permission | Gates |
|---|---|
| `administer ai` | the main AI settings form (`/admin/config/ai/settings`); defaults, logging, timeout, allowed hosts |
| `administer ai providers` | per-provider configuration (`/admin/config/ai/providers`), including Key selection |
| `access ai tools overview` | the overview listing of available AI tools |
| `administer ai prompt types` | create/edit/delete `ai_prompt_type` config entities |
| `manage ai prompts` | create/edit/delete individual `ai_prompt` entities |
| `administer guardrail sets` | create/edit/delete `ai_guardrail_set` entities |
| `administer guardrails` | create/edit/delete `ai_guardrail` entities |
| `access ai files overview` | the AI Files listing |
| `view own ai files` | view `ai_file` entities you own |
| `view any ai file` | view any `ai_file` regardless of owner |
| `delete own ai file` | delete `ai_file` entities you own |
| `delete any ai file` | delete any `ai_file` (restricted) |

Grant with drush, e.g.:

```bash
drush role:perm:add content_editor 'manage ai prompts'
drush role:perm:add administrator 'administer ai'
```

Note: `administer ai`, `administer ai providers`, and `access ai tools overview` are
security-sensitive — providers hold API credentials via the Key module and incur usage cost.
