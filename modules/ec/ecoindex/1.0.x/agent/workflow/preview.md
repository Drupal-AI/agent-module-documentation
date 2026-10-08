<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Preview route & the client-side measurement workflow

## Preview route `ecoindex.preview` (`ecoindex.routing.yml`)
- Path `/node/{node}/ecoindex`, `node: \d+`, param upcast to `entity:node`.
- `_controller: \Drupal\node\Controller\NodeViewController::view` and `_title_callback:
  ...::title` — it simply renders the node's canonical view; `_admin_route: false`.
- Requirement `_permission: 'update ecoindex field'`.

## Anonymous rendering — `PreviewUserSwitchSubscriber`
`src/EventSubscriber/PreviewUserSwitchSubscriber.php` (service
`ecoindex.preview_user_switch_subscriber`, injects `@account_switcher`). Subscribes to:
- `KernelEvents::REQUEST` (priority 20) → `onRequest()`: if `_route === 'ecoindex.preview'`,
  `accountSwitcher->switchTo(User::getAnonymousUser())` and sets a `switched` flag.
- `KernelEvents::RESPONSE` (priority 0) → `onResponse()`: if switched, `switchBack()`.

So the preview page is rendered as the **anonymous** visitor would see it — the measurement
reflects the public page weight, not the logged-in editor's toolbar/admin markup. (Route access
is still checked against the real user's `update ecoindex field` permission before the switch.)

## Attaching JS/settings — `ecoindex_page_attachments_alter()` (`ecoindex.module`)
- On `ecoindex.preview`: if the node has a field of type `ecoindex` (found via
  `ecoindex.helper`→`EcoIndexHelper::getEcoIndexFieldName()`), attaches library
  `ecoindex/ecoindex.preview` and `drupalSettings.ecoindex = {score, grade, minimum_score, nid}`.
- On `entity.node.edit_form`: if the node has an `ecoindex` field, attaches
  `ecoindex/ecoindex.edit` and `drupalSettings.ecoindex = {nid, field}`.

## Libraries (`ecoindex.libraries.yml`)
- `ecoindex.preview` → `js/preview.js`, depends on core drupal/drupalSettings/drupal.message and
  `ecoindex/cnumr.ecoindex`.
- `cnumr.ecoindex` → `js/ecoindex.js` — the bundled Green IT **GreenIT-Analysis** `ecoIndex.js`
  (v3.0.1, GPL-2.0-or-later; `remote:` points at github.com/cnumr/GreenIT-Analysis). Exposes
  `computeEcoIndex()` and `getEcoIndexGrade()`.
- `ecoindex.edit` → `js/edit.js`. `ecoindex.icon` → `css/ecoindex.icon.theme.css`.

## Measurement flow (all in the browser — no server-side API call)
1. `js/preview.js` on the preview page: counts DOM elements (excluding `.messages__wrapper`),
   reads `performance.getEntriesByType('resource')` for request count and summed `transferSize`
   (KB), then `computeEcoIndex(elementCount, requestCount, totalSizeKB)` → `score`, and
   `getEcoIndexGrade(score)` → `grade`.
2. It shows the score/grade via `Drupal.Message`, warns if `score < minimum_score`, and stores all
   five values in `localStorage` keyed by `ecoindex.<metric>.<language>.<nid>`.
3. The editor returns to the node edit form. `js/edit.js` reads those `localStorage` keys and
   writes the values into the widget's form inputs (`edit-<field>-0-score`, `-grade`,
   `-element-count`, `-request-count`, `-total-size-kb`), flagging changed fields with a "please
   save" notice or disabling unchanged ones.
4. Saving the node persists the values through the normal `ecoindex` field storage.

Because the score is computed and carried entirely client-side, the stored value is editor-supplied
form input (also directly editable in the widget) — treat it as advisory, not an authenticated
server measurement.

## Diff integration
With `drupal/diff` installed, the `ecoindex_field_diff_builder` plugin (schema
`diff.plugin.settings.ecoindex_field_diff_builder`) compares `score`, `grade`, `element_count`,
`request_count` and `total_size_kb` between revisions.
