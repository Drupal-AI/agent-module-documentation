# votingapi_widgets — agent start

Field-based rating/voting on top of Voting API. Add a **Voting API field** to an entity
bundle, pick a **widget** (`fivestar` / `like` / `useful`), and visitors vote inline via an
AJAX form. Depends on `votingapi` (^4.0) + core `field`. No dedicated config page — all setup
is on the field's storage/instance/display forms. Voting is gated by **dynamic per-field
permissions**. This module also **defines** the `VotingApiWidget` plugin type.

- Add a voting field, choose widget + result + formatter → [configure/field.md](configure/field.md)
- The `VotingApiWidget` plugin type; write a custom widget → [plugins/widgets.md](plugins/widgets.md)
- The per-field `VoteResultFunction` derivatives (average/count/useful) → [plugins/vote-results.md](plugins/vote-results.md)
- Per-field permissions (vote / edit own / clear / status) → [permissions/permissions.md](permissions/permissions.md)
- Services, hook classes, vote-submission flow → [api/services.md](api/services.md)

Five-star widget needs the jQuery Bar Rating JS lib at `/libraries/jquery-bar-rating`
(`hook_requirements` warns if missing); `like`/`useful` do not.
