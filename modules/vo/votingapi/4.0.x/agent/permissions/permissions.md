# Permissions

Defined in `votingapi.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer voting api` | Access the settings form (`/admin/config/search/votingapi`). |
| `administer vote types` | Create/edit/list/delete vote types (`/admin/structure/vote-types`); also the `vote_type` entity `admin_permission`. |
| `view own vote` | View one's own voting data. |
| `view any vote` | View voting data from any user. |
| `delete votes` | Delete any vote (checked by the vote access control handler alongside `delete_everywhere` / ownership logic). |

Access to individual `vote` entities is enforced by
`\Drupal\votingapi\VoteAccessControlHandler` (view = own vs. any per the
permissions above; delete gated by `delete votes`). `vote_result` access is
handled by `VoteResultAccessControlHandler`.
