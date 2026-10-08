<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring & running polls

Poll has almost no global config: `configure` route `poll.settings` (`/admin/config/content/poll`)
is a stub form that literally says "There are no settings yet." All behaviour is set **per poll**
on the poll entity's fields. There is no config schema and no exported settings to edit.

## Entities

- **`poll`** — content entity, base table `poll`, data table `poll_field_data`,
  label key = `question`, `admin_permission` = `administer polls`, translatable.
- **`poll_choice`** — content entity, base table `poll_choice`, label key = `choice`
  (a `string_long`). A poll references choices through its `choice` field.
- **Votes** are **not** entities — rows in the `poll_vote` table (chid, uid, hostname, timestamp),
  managed by the `poll_vote.storage` service.

## `poll` fields (set these to configure a poll)

| Field | Type | Default | Meaning |
|---|---|---|---|
| `question` | string (255) | — (required) | The poll question (entity label) |
| `choice` | entity_reference → `poll_choice`, unlimited | — (required) | The answer options |
| `status` | boolean | 1 | Published |
| `active` | boolean | 1 | Open for voting (0 = closed) |
| `runtime` | list_integer | 0 | Auto-close after N seconds; `0` = Unlimited (allowed values are fixed durations: 1–6 days, 1–3 weeks, 1–3/6/9 months, 1 year) |
| `auto_submit` | boolean | 0 | Submit vote form as soon as a choice is picked |
| `order_results` | list_string | `0` | `0` by weight, `1` votes ascending, `2` votes descending |
| `anonymous_vote_allow` | boolean | 0 | Let anonymous users vote |
| `anonymous_vote_restriction` | list_string | `ip` | `ip`, `session`, or `unlimited` |
| `cancel_vote_allow` | boolean | 1 | Let users cancel their own vote |
| `result_vote_allow` | boolean | 0 | Show results before voting |
| `uid` | entity_reference → user | current user | Author |
| `created` | created | now | Created timestamp |

## Admin routes

| Route | Path | Permission |
|---|---|---|
| `poll.poll_list` | `/admin/content/poll` | `administer polls` |
| `poll.poll_add` | `/poll/add` | create access to `poll` |
| `entity.poll.canonical` | `/poll/{poll}` | `poll.view` access |
| `entity.poll.edit_form` | `/poll/{poll}/edit` | `poll.update` access |
| `entity.poll.delete_form` | `/poll/{poll}/delete` | `poll.delete` access |
| `poll.poll_vote_delete` | `/poll/{poll}/delete/vote/{user}` | `access polls` |
| `poll.settings` | `/admin/config/content/poll` | `administer polls` |

## Block

`poll_recent_block` — admin label "Most recent poll", category "Lists (Views)". Place it in any
theme region (via Block layout or `block.block.*` config) to render the newest open poll.

## Views & tokens

Ships two default Views — `poll_list` and `poll_admin` (see `config/install/views.view.*`) — and
poll tokens (`poll.tokens.inc`, e.g. `[poll:...]`) for use in text.

## Fastest way to create a poll (drush)

```bash
drush php:eval '
use Drupal\poll\Entity\Poll; use Drupal\poll\Entity\PollChoice;
$p = Poll::create([
  "question" => "Tea or coffee?",
  "choice" => [PollChoice::create(["choice"=>"Tea"]), PollChoice::create(["choice"=>"Coffee"])],
  "status" => 1, "active" => 1, "runtime" => 0,
]);
$p->save();
print "poll ".$p->id()."\n";'
```

Saving the poll cascades: any unsaved referenced `poll_choice` entities are saved in `preSave()`,
and choices removed from the field are deleted along with their votes. Deleting a poll deletes its
choices and votes too (`postDelete()`).
