<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# et_transaction entity

Defined by `src/Entity/EtTransaction.php` (`@ContentEntityType id = "et_transaction"`), interface
`src/EtTransactionInterface.php`. Base table `et_transaction`, data table `et_transaction_field_data`; translatable
(`ContentTranslationHandler`); uses `EntityPublishedTrait` + `EntityChangedTrait`.

Entity keys: `id`, `label` = `title`, `uuid`, `langcode`, `published` = `status`, `owner` = `uid`.
`admin_permission = administer et_transactions`; `field_ui_base_route = expense_tracker.settings`.
Links: canonical `/et-transaction/{et_transaction}`, edit-form `/admin/income-expense-transactions/{id}/edit`,
delete-form `/admin/income-expense-transactions/{id}/delete`.

Handlers: `access` → `EtTransactionAccessControlHandler`; `storage` → `EtTransactionStorage`; `list_builder` →
`EtTransactionListBuilder`; `view_builder` → `EtTransactionViewBuilder`; `views_data` → `EtTransactionViewData`;
forms `default`/`edit` → `EtTransactionForm`, `delete`/`delete_transaction` → `EtTransactionDeleteForm`,
`delete_items` → `EtTransactionItemsDeleteForm`.

## Base fields (`baseFieldDefinitions()`)
- `title` (string, required, translatable, max 255) — label.
- `transaction_category` (list_string) — entry mode `new` | `existing` (default `new`); `existing` links to a parent.
- `category` (entity_reference → et_transaction) — parent category transaction (top-level only).
- `amount` (float, required) — monetary value; must be ≥ 0 (negatives rejected on save/validation).
- `date` (created/datetime, required) — when the transaction occurred; defaults to now.
- `transaction_type` (list_string) — `expense` | `income` (default `expense`).
- `repeat` (boolean) + `repeat_every` (list_string: day/week/month/year/working_days/specific_week_days/
  specific_month_days) + `specific_week_days` (multi 1–7) + `specific_month_days` (multi 1–31) + `end_date`
  (timestamp, default +1 month via `EtTransaction::getEdate()`) — recurrence.
- `note` (text_long, max 1024, `text_format` widget) — optional memo.
- `uid` (entity_reference → user, required) — owner; default `getCurrentUserId()`.
- `created_type` (list_string manual|automatic), `parent_category` (int, default 0),
  `parent_transaction_id` (int, default 0), `last_transaction_time` (int, default 0) — bookkeeping.
- `status` (boolean, default TRUE) — published; unpublished records are excluded from reports/charts/API.
- `comment` (comment field, comment_type `et_transaction_comment`), plus `langcode`, `created`, `changed`.
- `path` (computed, added by `expense_tracker_entity_base_field_info()`) — URL alias widget.

Getters/setters on the entity: `getTitle/setTitle`, `getAmount`, `getCreated/setCreated`, `getOwner/getOwnerId/
setOwner/setOwnerId`, `getParentCategory/setParentCategory`, `isOpen/isClosed/open/close`, plus legacy no-op
`getOptions()/getOptionValues()` (kept only to satisfy the interface). `sort()` compares by label.

## Access model (`EtTransactionAccessControlHandler`)
- `checkCreateAccess()`: allowed for `access expense_tracker` OR `administer et_transactions`.
- `checkAccess()`: users in the `administrator` role get full access. Otherwise, per operation:
  - `view`: `access all expense_tracker`, or (owner AND `access expense_tracker`).
  - `update`: `edit all expense_tracker`, or (owner AND `edit expense_tracker`).
  - `delete`: `delete all expense_tracker`, or (owner AND `delete expense_tracker`).
  - default `forbidden()`.
- `checkFieldAccess()`: editing the `uid` (author) field requires `administer expense_tracker`.

Entity routes wire these: canonical/edit/delete use `_entity_access: et_transaction.{view,update,delete}`; add uses
`_entity_create_access: et_transaction`; the list route uses `_permission: access expense_tracker`.

## Storage (`EtTransactionStorage` / `EtTransactionStorageInterface`)
Extends `SqlContentEntityStorage`. Adds `getEtTransactionDuplicates()` (same title, different id) and
`getExpiredEtTransactions()` (status=1, runtime≠0, now > created+runtime — legacy expiry helper).

## Forms & UI
`EtTransactionForm` renders the add/edit form; `expense_tracker_form_alter()` adds currency prefix/suffix on the
amount field, per-field help text, `#states` show/hide for category and repeat fields, an AJAX title sync
(`expense_tracker_update_category_data`), locks fields on auto-generated children, and switches the form to the
two-column `et_transaction_form_layout` theme (Claro/Gin `form-two-columns`). `entity_presave` defaults the date
and syncs a child's title from its parent category. The admin list is the `expense_tracker_admin` View (VBO-enabled);
`EtTransactionListBuilder` is the entity-list fallback. Amounts are rendered via
`expense_tracker_format_currency()` in `hook_preprocess_field` and `hook_preprocess_views_view_field`.
