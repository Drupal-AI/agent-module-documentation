# Search API Synonym — permissions

Source: `search_api_synonym.permissions.yml`. None are marked `restrict access: true`.

| Permission | Gates |
|---|---|
| `administer search api synonyms` | Full access to the synonym admin: list, add, edit, delete, delete-all. Also the entity `admin_permission`. |
| `administer search api synonym configuration` | The export/cron settings form (`.../settings`). |
| `import search api synonyms` | The import UI (`.../import`) — upload a CSV/JSON/Solr file that is parsed into `search_api_synonym` content entities. |
| `view search api synonyms` | View synonym entities. |

Notes:
- `import search api synonyms` is not `restrict access: true`, but it only lets a holder create synonym
  *content* records (word/synonym/type) from an uploaded file whose extension is validated against the
  active import plugin. It does not grant configuration or any cross-boundary capability, so it is
  reasonable to grant to a content-team role.
