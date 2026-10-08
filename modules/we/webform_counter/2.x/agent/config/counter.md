<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Webform submissions counter

## Install & enable

```bash
composer require drupal/webform_counter
drush en webform_counter -y
```

Only dependency is **Webform** (`webform:webform`). No sub-modules, no permissions, no Drush
commands, no `config/install`, no admin settings route of its own.

## Per-webform settings (third-party settings)

`hook_webform_third_party_settings_form_alter()` in `webform_counter.module` adds a **Submissions
Counter** details section to each webform's *Settings → Third party settings*. Values are stored on
the webform config entity under the `webform_counter` third-party namespace:

| Setting key | Type | Meaning |
|---|---|---|
| `offline_submissions_count` | integer | Added to the live submission total (seed with historical/offline counts). Optional; treated as `0` if empty. |
| `target_submissions_count` | integer | Goal used for the progress bar. **The progress bar only renders when this is set.** Optional. |
| `submissions_count_text` | plural label | Singular/plural phrasing; `@count` is replaced with the number. Stored as the plural forms joined by `PoItem::DELIMITER`. **The counter renders nothing unless both singular and plural are non-empty.** |

The form builds one text field per plural form for the webform's language (via
`locale.plural.formula`), defaulting to Singular/Plural when two forms. On submit,
`_webform_counter_settings_form_validate()` `implode()`s the plural array back into the single
`submissions_count_text` string with `PoItem::DELIMITER`.

Config schema: `webform.settings.third_party.webform_counter` in
`config/schema/webform_counter.schema.yml` (`offline_submissions_count` integer,
`target_submissions_count` integer, `submissions_count_text` `plural_label`).

## Tokens

`hook_token_info_alter()` registers two dynamic `site` tokens; `hook_tokens()` renders them:

- `[site:webform-counter:MACHINE_NAME]` → `type = basic` (text only)
- `[site:webform-counter-progress:MACHINE_NAME]` → `type = progress` (progress bar + text)

The token part after the second `:` is the **webform machine name**. `hook_tokens()` does **not**
query the count itself — it emits a placeholder and defers to AJAX:

```html
<span class="webform-counter webform-counter--placeholder webform-counter--{type}"
      data-webform-counter="{json}" id="{unique-id}" />
```

`{json}` (built with `json_encode` and rendered through a Twig `inline_template`, so it is
auto-escaped) carries `url` = `Url::fromRoute('webform_counter.ajax_counter')`, and `submit` =
`{ webform: MACHINE_NAME, type, selector: '#unique-id' }`. The token also attaches library
`webform_counter/counter`.

Placement notes (from README + the settings-form description):

- Put the token in an **Advanced HTML/Text** element using the **Full HTML** text format, or in any
  token-aware text/block/view.
- If the token lands in *processed* text, **disable the `filter_html` filter** for that text format
  or the placeholder `<span>` is stripped.
- The counter appears **after** page load (JS/AJAX), not immediately, and is therefore not part of
  the page cache.

## AJAX endpoint & count computation

Route (`webform_counter.routing.yml`):

```yaml
webform_counter.ajax_counter:
  path: '/webform-counter/ajax-counter'
  defaults:
    _controller: '\Drupal\webform_counter\Controller\AjaxController::counter'
  requirements:
    _access: 'TRUE'
```

`js/webform_counter.progress.js` (`Drupal.behaviors.webformCounter`) runs
`Drupal.ajax(data).execute()` for each placeholder, POSTing `webform`, `type`, `selector`.

`AjaxController::counter(Request $request)` (`src/Controller/AjaxController.php`):

1. Validates params: `webform` must be a non-empty scalar (else HTTP 400), the webform must load
   (else 400), `type` must be `basic` or `progress` (else 400), `selector` must be a non-empty
   scalar (else 400).
2. Requires `submissions_count_text` to have both singular and plural non-empty, else returns
   **HTTP 406** ("Counter is not setup for this webform").
3. Computes the count:
   `count = WebformSubmissionStorageInterface::getTotal($webform) + offline_submissions_count`
   (offline defaults to `0`). Uses the Webform submission entity storage — no raw SQL.
4. Formats it with `PluralTranslatableMarkup::createFromTranslatedString($count,
   $submissions_count_text)`.
5. For `type === 'progress'` **and** a non-zero target, renders core `#theme => 'progress_bar'`
   with `percent = round(100 * count / target)` clamped to `[0, 100]`.
6. Returns an `AjaxResponse` with a `ReplaceCommand($selector, …)` that swaps the placeholder for
   `<span class="webform-counter webform-counter--wrapper …">{progress_bar}<span
   class="webform-counter--text">{content}</span></span>`. Both `content` and `type` go through a
   Twig `inline_template` (auto-escaped); `PluralTranslatableMarkup` is safe markup.

## Behavior summary

- No counter renders unless the singular **and** plural count text are set (406 from the endpoint).
- No progress bar renders unless `target_submissions_count` is set (basic text still shows).
- The displayed number is the live submission total **plus** the offline base count.
- Everything is display-only: the module never blocks, caps, or alters submissions — it does not
  enforce a limit, only shows progress toward the (informational) target.
