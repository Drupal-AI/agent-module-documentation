<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Client-side behavior (JS plugin)

Source: `js/ckeditor_historylog/js/ckeditor5_plugins/history_log/src/` (built to
`js/build/history_log.js`). All persistence is browser `localStorage`; nothing is sent to Drupal.

## Plugin wiring (`index.js`, `historylog.js`)

`index.js` exports `{ HistoryLog }`. `HistoryLog extends Plugin`, `requires [HistoryLogUI]`,
`pluginName = 'HistoryLog'`.

Constructor:
1. `editor.config.define('historyLog', {...})` — JS defaults (see config subdoc; the Drupal PHP
   plugin overrides most of these).
2. `createStorageKey(editor)` — computes and stores `historyLog.saveKey`.
3. Sets core `autosave` config: `waitingTime` = `historyLog.waitingTime`, and a `save(editor)`
   callback that calls `saveData(getStorageKey(editor), editor)` (default `initiatorType='autosave'`).

`init()`:
- Registers command `historyLogRevert` → `HistoryLogCommand`.
- On editor `ready` (once): `purgeExpiredLogs(editor)` then `preventPageExitConfirmation(editor)`
  (removes core Autosave's `beforeunload` handler so unsaved-autosave never blocks leaving) then
  `saveData(storageKey, editor, 'load')` (records an initial `load` revision).
- Overrides core `Notification` `show:info` to a native `alert(message)` and `evt.stop()`.

## Storage key (`storage.js createStorageKey`)

`key = saveKeyPrefix + delimiter + url + delimiter + sourceElement.getAttribute(saveKeyAttribute)`
— default `cklog_<path>_<attr>`. If `saveKeyIgnoreParams` (default true) the URL is reduced to its
pathname (`removeUrlParameters`), else the full `location.href`. The key is stored back into
`historyLog.saveKey` and read via `getStorageKey()`. Origin-scoped (localStorage same-origin),
per-page-path, per editor field — NOT keyed by Drupal user id.

## Save / load / compression (`storage.js`)

- `saveData(key, editor, initiatorType='autosave')`: builds `{id: Date.now(), saveTime, type,
  dataHash: generateHash(data), data: editor.getData()}`. Skips an autosave that lands right after
  a `rollback` (within `waitingTime+2000` ms). Runs `condenseHistory()`, pushes the new entry,
  `compress()`es `{saveTime, logs}` and `localStorage.setItem`. A `QuotaExceededError` is caught
  and only `console.log`ged (the save is silently dropped).
- `loadData(key)`: reads the item, `decompress()`, returns `data.logs ?? []` (or `null` if empty).
- `compress`/`decompress`: gzip via `CompressionStream`/`DecompressionStream` + base64
  (`bufferToBase64`/`base64ToBytes`). So values are base64(gzip(JSON)), not plaintext.
- `condenseHistory()`: if `length >= limit` shift the oldest; if the stored (compressed) string
  length `> maxSize`, `splice` off the older half.
- `purgeExpiredLogs()`: scans ALL `localStorage` keys starting with `saveKeyPrefix+delimiter`,
  decompresses each, removes any whose top-level `saveTime` is older than `expireMinutes`.
- `getRevisionById(id, history)`: `find(d => d.id === id)`.

## Revert command (`command.js`)

`HistoryLogCommand.execute(id)`: loads history; `showInfo` (→ alert) if none / id missing / the
revision equals current `editor.getData()`. If `saveBeforeRestore` (default true), first
`saveData(..., 'rollback')` to snapshot current content, then `editor.setData(revisionData.data)`
and refocus. `refresh()` keeps `isEnabled = true`.

## Dropdown UI (`ui.js`, `ui-shim.js`)

`HistoryLogUI` registers the `historyLog` toolbar component as a dropdown (`createDropdown` +
`addListToDropdown`) using `theme/icons/history_log.svg`. On button click,
`_createDropdownOption()` loads history, reverses it (newest first), and builds a menu item per
revision labelled `timeSince(id) + ' ago'` (plus `- <type>` when type ≠ `autosave`). Entries whose
`dataHash` matches current content get class `ck-history-log-dropdown__same-data`, and are skipped
entirely when `ignoreSameData` is on; a separator is added after a `load` entry. Selecting an item
executes `historyLogRevert` with that revision id. `ui-shim.js` maps `ViewModel`→`Model` for
CKEditor 5 < 41 (Drupal 10.2) compatibility.

## Helpers (`utility.js`)

- `timeSince(unixMs)`: humanized "N seconds/minutes/.../years" for the dropdown labels.
- `generateHash(str)`: 32-bit non-cryptographic hash (bit-shift), used only to dedupe identical
  revisions — no security reliance.
