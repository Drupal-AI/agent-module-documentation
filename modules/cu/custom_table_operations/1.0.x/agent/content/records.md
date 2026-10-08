<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Row-level CRUD on a registered table

Once a `dbtable` definition exists (see [../config/dbtable.md](../config/dbtable.md)), these
routes read and mutate the **actual rows** of the named table via the core database API. Every
route requires the core permission **`administer site configuration`**.

## Listing — `TableContentController::Listing($dbtable, $pk)`

`src/Controller/TableContentController.php`. Route `entity.dbtable.content`,
`/admin/config/system/dbtable/{dbtable}/{pk}/list`.

- Loads the `dbtable` entity by `{dbtable}` to get `field_list`.
- Header = `[pk => pk]` + `field_list` + an `opt` (Operation) column.
- Query: `Database::getConnection()->select($dbtable, 'm')->fields('m', [pk] + field_list)` then
  `execute()->fetchAll()`. (The commented-out code shows an earlier `DESCRIBE`-based header.)
- Per row it renders an **Edit** link (`entity.dbtable.content_edit_form`) and a **Delete** link
  (`entity.dbtable.content_delete`), both keyed on `cid = row[pk]`, into the `opt` cell via the
  renderer.
- Caption is an **"Add new record"** link (`entity.dbtable.content_add_form`). Empty table →
  `#empty` "Tables is empty!". Returns a `#type => table` render array.

Note `{dbtable}` here is the entity **label** (= the real table name) passed through from the list
builder's row link, and `{pk}` is the configured primary-key column.

## Add / edit a row — `TableContentForm`

`src/Form/TableContentForm.php` (`FormBase`, form id `dbtable_form`). Used by both
`entity.dbtable.content_add_form` (`…/{dbtable}/{pk}/add`) and
`entity.dbtable.content_edit_form` (`…/{dbtable}/{pk}/update/{cid}`).

- `buildForm()` reads `{dbtable}`, `{pk}`, `{cid}` from the route match, loads the entity's
  `field_list`, and builds a `textfield` for each of `[pk] + field_list`, all `#required`.
- On **edit** (`{cid}` present) it pre-fills by
  `select(table)->condition(pk, cid)->fields(...)->fetchAssoc()`.
- Submit buttons: **Save** plus a Cancel link back to the listing.
- `submitForm()`:
  - **Edit** (`cid` set): `update($table)->fields($values)->condition($pk, $cid)->execute()`,
    then a success/error message.
  - **Add**: first `select(...)->condition(pk, values[pk])->countQuery()` — if the key already
    exists it errors ("Record with id … already exists"); otherwise
    `insert($table)->fields($values)->execute()` and a success message.
  - Redirects to `entity.dbtable.content` for that table/pk.

`$fields` for the write come from `$form_state->cleanValues()->getValues()`, i.e. exactly the
form's per-column textfields.

## Delete a row — `TableContentDeleteForm`

`src/Form/TableContentDeleteForm.php` (`ConfirmFormBase`). Route `entity.dbtable.content_delete`,
`…/{dbtable}/{pk}/delete/{cid}`. Standard confirm step (question "Are you sure to delete this
record? This action cannot be undone.", confirm "Delete it"). `submitForm()` runs
`\Drupal::database()->delete($table)->condition($pk, $cid)->execute()`, messages
success/error, and redirects back to the listing.

## Operating notes

- All row writes are keyed on the single configured **primary-key column**; a table without a
  reliably unique value in that column will mis-target updates/deletes.
- Every displayed column is `#required` on the add/edit form, so rows with legitimately empty
  columns cannot be saved through the UI.
- Mutations are state-changing form submissions (POST, with the delete behind a confirm step);
  the listing route is a read-only render.
- These operations run against the raw table with **no per-row entity access model** — the only
  gate is the `administer site configuration` permission on the routes.
