<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extending Activity Stream with a new service

A service is registered by any module and feeds items into the stream. Four hooks:

1. **Declare** — `hook_actstream_services()` returns definitions keyed by service machine name, each with `type`, `name`, `verb`, `icon`.
2. **Per-user config** — `hook_form_actstream_accounts_form_alter(&$form, $form_state)` appends fields to the accounts form (`$form['#user']` holds the target user) and attaches a submit handler that calls `actstream_account_save($service, $data, $uid)`.
3. **Fetch** — `hook_actstream_SERVICE_items_fetch($uid, $data)` contacts the remote API (inject `http_client`; Guzzle verifies TLS by default) and returns normalised item arrays with keys `title`, `body`, `link`, `timestamp`, `guid`, `raw`.
4. **Alter (optional)** — `hook_actstream_SERVICE_items_alter(&$items, $uid, $data)`.

Persist fetched items with `actstream_items_save($uid, $service, $items)` — it dedupes on `guid` (falling back to `link`) and skips unchanged entities. Load with `actstream_items_load($uid)` (published + access-checked). Full worked examples live in `actstream.api.php`.

Fetching is driven by cron (`hook_cron`) and the `actstream:fetch` Drush command, which iterate rows of `actstream_account`, `unserialize()` the stored `data`, and invoke the fetch hooks.
