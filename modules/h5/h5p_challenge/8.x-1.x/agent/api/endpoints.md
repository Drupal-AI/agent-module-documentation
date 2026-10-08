<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# H5P Challenge — gameplay endpoints & REST

Controller `Drupal\h5p_challenge\Controller\H5PChallengeController`. All gameplay routes are `_access: TRUE` (anonymous, no_cache) because play happens in the H5P iframe.

| Route | Path | Purpose |
|---|---|---|
| create_new | `h5p_challenge/create-new.json` | Create a challenge (reCAPTCHA required); emails creator |
| start_playing | `h5p_challenge/start-playing.json` | Join by code; creates a player points row |
| set_finished | `h5p_challenge/set-finished.json` | POST score/maxScore/uuid → stores xAPI result |
| settings | `h5p_challenge/settings.json` | Client settings |
| results / results_csv | `h5p_challenge/{challenge}/results[/csv]` | Leaderboard / CSV export |

Each expects a non-empty `token` GET param. `set-finished` writes points where
`player_uuid = <uuid>` and requires the challenge to be `isActive()`.

## REST submodule `h5p_challenge_rest` (needs `rest`)
Read resources (enable + grant per-resource permissions via `rest` config):
- `api/h5p_challenge/challenge/{uuid}/results` — paginated points, `from`/`until` timestamp filters, `totalPages` meta.
- Plus `All`, `UserChallenges` resources. Queries use the parameterized DB builder with a custom fetch class.
