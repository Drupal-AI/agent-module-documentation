# tmgmt_local — agent start

TMGMT translator (provider) submodule for **in-Drupal human translation**. Registers the
**`local`** translator plugin (`Drupal\tmgmt_local\Plugin\tmgmt\Translator\LocalTranslator`,
namespace `Plugin/tmgmt/Translator`). Part of the `tmgmt` project. Depends on `tmgmt` and
`tmgmt_language_combination`. Configured on the Providers page
(`entity.tmgmt_translator.collection`).

How it works:
- Submitting a job to a `local` provider creates a **`tmgmt_local_task`** content entity with
  **`tmgmt_local_task_item`** children — the work queue shown under `/translate`.
- Translators translate segments in the UI and mark items complete; the result returns to the
  originating `tmgmt_job` for the normal TMGMT review/accept flow.
- Task routes: `/translate/{tmgmt_local_task}` (view), `.../assign`, `.../assign_to_me`,
  `.../unassign`, `.../delete`, `/translate/assign-multiple` (bulk),
  `/translate/items/{tmgmt_local_task_item}` (translate an item).

Permissions (`tmgmt_local.permissions.yml`):
- `provide translation services` — eligible to receive/perform translation tasks.
- `administer translation tasks` — manage and assign all tasks.

Eligibility uses the **tmgmt_language_combination** field (required dependency) recording each
user's source→target language pairs, so tasks are only offered to capable translators.

For the Translator plugin type / building your own provider, see the parent:
[../../../../1.18.x/agent/plugins/tmgmt.md](../../../../1.18.x/agent/plugins/tmgmt.md).
