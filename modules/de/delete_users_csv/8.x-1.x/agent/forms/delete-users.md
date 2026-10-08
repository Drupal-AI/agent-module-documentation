<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Delete Users CSV — the upload form and batch deletion

Everything the module does is in three files: `delete_users_csv.routing.yml`,
`src/Form/DeleteUsersCsv.php`, and `src/DeleteUsersBatch.php`.

## Install / enable

- `composer require drupal/delete_users_csv` then `drush en delete_users_csv`. No dependencies,
  no config to import, no schema. Requires Drupal core `^10.3 || ^11.0`.
- After enabling, the form is at **`/admin/delete-users-csv`** and a *Delete Users CSV* menu link
  appears under **People** (Admin › People, weight 99).

## Route & access

`delete_users_csv.routing.yml`:

```
delete_users_csv.upload_file:
  path: '/admin/delete-users-csv'
  defaults:
    _form: '\Drupal\delete_users_csv\Form\DeleteUsersCsv'
    _title: 'Delete users from uploaded CSV file'
  requirements:
    _permission: 'administer users'
```

- Access is the core **`administer users`** permission — the standard trusted user-management
  permission. There is no module-specific permission.
- It is a `_form` route, so it is a standard Drupal FormBase submission: the Form API applies its
  CSRF token and the managed-file upload validators automatically.

## The form — `DeleteUsersCsv` (extends `FormBase`)

- `getFormId()` → `delete_users_csv_form`.
- `buildForm()` defines one required field `users_file`:
  - `#type => 'managed_file'`, `#title` "File of email addresses", `#required => TRUE`.
  - `#upload_validators => ['FileExtension' => ['csv']]` — only `.csv` is accepted.
  - `#upload_location => 'public://'` — the uploaded file is saved to the public files directory.
  - Description: *"CSV format only. Will delete users for any email address in any row or column
    of the file."*
- Submit button label: *"Upload CSV and delete users"*.

## Submit handler — parsing the CSV

`submitForm()`:

1. Reads the uploaded fid from `$form_state->getValue('users_file')[0]`, loads the `File` entity
   (`Drupal\file\Entity\File::load($fid)`), and gets its URI from `$file->toArray()['uri'][0]['value']`.
2. `fopen($destination, 'r')`, then a `while (!feof($file))` loop calling `fgetcsv($file)`.
3. For each cell `$value` in the row: `if (str_contains($value, '@'))` it is added to
   `$users_emails`, trimmed with `trim($value, " \n\r\t\v\x00\xEF\xBB\xBF")` (whitespace, NUL and
   the UTF-8 BOM). So **any cell in any column/row that contains `@`** is treated as an email.
4. Builds a batch with one operation `[DeleteUsersBatch::class, 'deleteUsers']` passing
   `[$users_emails]`, finished callback `deleteUsersCallback`, and calls `batch_set($batch)`.

Notes for callers:
- Matching is literal substring on `@`; there is no email-format validation, so a malformed value
  containing `@` simply won't match any account and is a no-op.
- The saved CSV in `public://` is **not deleted** by the module after processing.

## Batch — `DeleteUsersBatch` (static callbacks)

- `deleteUsers($users_emails, &$context)`: if the list is non-empty, gets user storage
  (`\Drupal::entityTypeManager()->getStorage('user')`) and, for each address,
  `loadByProperties(['mail' => $value])` then `$user->delete()` for each returned account.
  Collects the delete return values into `$context['results']`. Deletion is a single operation
  (not chunked), so a very large list runs in one pass.
- `deleteUsersCallback($success, $results, $operations)`: on success adds a status message via
  `formatPlural(count($results), 'One user deleted.', '@count users deleted.')`, otherwise
  "Finished with an error."; logs the message to the `delete_users_csv` logger channel.

## Operating it

1. Build a CSV whose cells contain the target email addresses (a single column of emails is the
   simplest; extra columns are ignored unless they also contain `@`).
2. Go to `/admin/delete-users-csv`, upload the file, submit.
3. Watch the batch progress; the final status message states how many accounts were deleted.
   Confirm the count matches your expectation, since matching is by email and unmatched addresses
   are silently skipped.

## Caveats

- Deletion is by **email match** and irreversible; an address that matches an account you did not
  intend to remove (including privileged accounts) will delete that account. Review the CSV before
  uploading.
- `$user->delete()` removes the account and, per core defaults, its authored content depends on the
  entity's delete behavior — this module does not present the core "cancel account" method options.
