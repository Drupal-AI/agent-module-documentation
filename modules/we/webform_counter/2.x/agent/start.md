<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Counter (webform_counter) — agent index

Displays a **live submissions count** (optionally a **progress bar** toward a target) for a
Webform, exposed as two site tokens that a small AJAX behavior fills in after page load. Package
**Webform**. Depends on **`webform:webform`**. Core `^8 || ^9 || ^10 || ^11`. License
GPL-2.0-or-later. Version 2.0.1 (doc dir `2.x`).

- **Configure the per-webform counter, the tokens, the AJAX endpoint, and how the number is
  computed** → [config/counter.md](config/counter.md)

## What it actually is

- **No plugins, no entities, no permissions, no Drush, no config-install.** The whole module is
  four hooks in `webform_counter.module` plus one AJAX controller.
- Adds a **"Submissions Counter"** section to each webform's third-party settings via
  `hook_webform_third_party_settings_form_alter()`, storing three values under the
  `webform_counter` third-party namespace: `offline_submissions_count`,
  `target_submissions_count`, `submissions_count_text` (singular/plural, joined by
  `PoItem::DELIMITER`). Config schema for these is `webform.settings.third_party.webform_counter`
  (`config/schema/webform_counter.schema.yml`).
- Registers two dynamic site tokens via `hook_token_info_alter()` /`hook_tokens()`:
  - `[site:webform-counter:MACHINE_NAME]` → text only (`type = basic`)
  - `[site:webform-counter-progress:MACHINE_NAME]` → progress bar + text (`type = progress`)
  Each token renders an **empty placeholder** `<span class="webform-counter--placeholder …"
  data-webform-counter="{…}">` carrying the AJAX URL and submit params, and attaches library
  `webform_counter/counter`.

## Mechanism (from source)

- `js/webform_counter.progress.js` (`Drupal.behaviors.webformCounter`) finds each
  `span[data-webform-counter]` and runs `Drupal.ajax(data).execute()`, POSTing to the counter
  route.
- Route `webform_counter.ajax_counter` → path `/webform-counter/ajax-counter` →
  `AjaxController::counter()` (in `src/Controller/AjaxController.php`). It validates the POST params
  (`webform`, `type` ∈ {basic, progress}, `selector`), loads the webform, requires the count text
  to be configured (else HTTP 406), then computes
  `WebformSubmissionStorageInterface::getTotal($webform) + offline_submissions_count`.
- The number is wrapped with `PluralTranslatableMarkup::createFromTranslatedString($count,
  $submissions_count_text)`, the progress bar is core's `#theme => 'progress_bar'` with
  `percent = clamp(round(100 * count / target), 0, 100)`, and the result is returned as an
  Ajax `ReplaceCommand` on the placeholder's selector.

## Operate it

1. `drush en webform_counter -y` (Webform must be present).
2. On the webform: **Settings → Third party settings → Submissions Counter** — fill in the
   singular/plural count text (required for the counter to render), and optionally the offline
   base count and the target count (target is required for the progress bar to show).
3. Add an **Advanced HTML/Text** element using **Full HTML** and insert the token
   `[site:webform-counter-progress:MACHINE_NAME]` (or the plain `webform-counter` variant). If the
   token is placed in processed text, disable the `filter_html` filter for that text format so the
   placeholder markup survives.

Details, setting keys, param validation, and the count formula: **[config/counter.md](config/counter.md)**.
