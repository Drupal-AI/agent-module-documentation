# Permissions

`ai_agents.permissions.yml` defines one permission:

| Permission | Gates |
|---|---|
| `administer ai_agent` | Administer AI Agent config entities (create/edit/delete agents and overrides). Trusted/admin. |

Submodules add their own (documented with each submodule):
- `ai_agents_explorer`: `use the agent explorer`, `administer ai_agent_decision`.
- `ai_agents_form_integration`: `create ai assisted webforms`, `create ai assisted field types`
  (+ `create ai assisted content types`, supplied dynamically).

```
drush role:perm:add administrator 'administer ai_agent'
```
