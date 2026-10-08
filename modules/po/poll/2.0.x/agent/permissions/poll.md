<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `poll.permissions.yml` (9 permissions). `administer polls` is the entity
`admin_permission` for both `poll` and `poll_choice`.

| Permission | Restricted? | Gates |
|---|---|---|
| `administer polls` | yes | Full control: the admin list `/admin/content/poll`, settings, and all poll/choice operations |
| `access polls` | no | View polls and cast a vote (title "View polls"); required before voting is allowed |
| `access poll overview` | no | Reach the Poll overview page |
| `access unpublished polls` | yes | Always view polls even when unpublished |
| `create polls` | no | Create new polls (`/poll/add`) |
| `cancel own vote` | no | Cancel and recast one's own vote (also needs the poll's `cancel_vote_allow`) |
| `edit any polls` | no | Edit any poll |
| `edit own polls` | no | Edit only polls you authored |
| `view poll results` | no | Always see results without voting, even when the poll hides pre-vote results |

Notes:
- Voting requires `access polls`; `isVotingAllowed()` also checks the poll is open, and for
  anonymous users that `anonymous_vote_allow` is set plus the IP/session restriction.
- Cancelling requires `cancel own vote` **and** the poll's `cancel_vote_allow` **and** an open poll.
- There is no separate "delete polls" permission — deletion is covered by `administer polls`
  / the poll entity access handler (`edit any`/`edit own` for update).
