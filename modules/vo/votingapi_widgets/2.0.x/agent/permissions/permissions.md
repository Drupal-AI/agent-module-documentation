# Permissions

`votingapi_widgets.permissions.yml` declares a single **permission callback**:
`Drupal\votingapi_widgets\FieldPermissions::permissions`. There are no static permissions —
they are generated dynamically, **one set per Voting API field** on the site.

`FieldPermissions::permissions()` iterates every `voting_api_field` instance
(`getFieldMapByFieldType`) and, for each `entity_type:bundle:field_name`, emits four permissions:

| Permission machine name | Gates |
|-------------------------|-------|
| `vote on <et>:<bundle>:<field>` | Casting a new vote |
| `edit own vote on <et>:<bundle>:<field>` | Changing one's existing vote (within the rollover window) |
| `clear own vote on <et>:<bundle>:<field>` | Removing one's own vote |
| `edit voting status on <et>:<bundle>:<field>` | Opening/closing voting (the Open/Closed status radios) |

Example for a `field_rating` on article nodes:
`vote on node:article:field_rating`, `edit own vote on node:article:field_rating`, etc.

## Where they are enforced
- **`VotingApiWidgetBase::canVote($vote)`** — checks `vote on …` for a new vote, or
  `edit own vote on …` for an existing one. `BaseRatingForm::save()` refuses to persist the vote
  unless `canVote()` is TRUE, so the AJAX submit is access-checked server-side.
- **`VotingApiWidget` field widget** (`formElement`) — the status radios render only with
  `edit voting status on …`; the seeded "Your vote" select renders only with `vote on …`.

Grant `vote on …` to the anonymous role to allow anonymous voting (double-voting is limited by
the field's anonymous rollover window, keyed on IP). Adding a new voting field creates a new set
of permissions to assign at `/admin/people/permissions`.
