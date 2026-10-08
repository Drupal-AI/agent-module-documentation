<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AdInsight Clarity — configuration & placement

## Install & enable

```bash
composer require drupal/adinsight_clarity   # or place in modules/contrib
drush en adinsight_clarity -y
```

No module dependencies. The contrib **`token`** module is optional — only needed for the tokens
to appear in the token-browser UI (the tokens themselves are always registered). An active
**AdInsight / ResponseTap** account is required for the numbers to swap and calls to be tracked.

## Settings form & route

- Route **`adinsight_clarity.admin_settings_form`** → path `/admin/config/tracking/adinsight_clarity`.
- Requirement: `_permission: 'administer adinsight clarity'` (declared in
  `adinsight_clarity.permissions.yml`, title *"Administer AdInsight Clarity"*).
- Menu link `adinsight_clarity.admin_settings_form` (parent `system.admin_config_services`).
- Form class `Drupal\adinsight_clarity\Form\AdminSettingsForm` extends `ConfigFormBase`
  (standard POST + form-token protected); `getEditableConfigNames()` → `adinsight_clarity.settings`.

Three required fields (all `#required`, all validated in `validateForm()`):

| Field | Config key | Validation (`validateForm`) | Notes |
|---|---|---|---|
| AdInsight Clarity Account | `account` | `preg_match('/^[0-9]{1,}$/')` — numeric only, maxlength 10 | Passed to the vendor script as `window.adiInit`. |
| Base telephone number | `base_phone` | `preg_match('/^[0-9 ]{1,}$/')` — digits and spaces, maxlength 20 | Rendered server-side as the fallback / pre-swap number. |
| Dynamic Number Pool ID | `pool` | `preg_match('/^[0-9]{1,}$/')` — numeric only, maxlength 4 | Selects the AdInsight number pool; also becomes CSS class `adinsightNumber{pool}`. |

On a valid save, `submitForm()` writes `account`, `pool`, `base_phone` to the config object and
`validateForm()` calls `drupal_static_reset('_adinsight_clarity_build_tag')` so the cached span
rebuilds. The form's *Usage* fieldset only appears once `pool` and `base_phone` are set, and it
prints the exact span to copy.

## Config object & schema

Config object **`adinsight_clarity.settings`**:

```yaml
# config/install/adinsight_clarity.settings.yml  (defaults, all empty)
account: ''
pool: ''
base_phone: ''
```

Schema (`config/schema/adinsight_clarity.schema.yml`) types all three as `string`. `hook_uninstall()`
in `adinsight_clarity.install` deletes this object on uninstall. These values are non-secret
tracking identifiers (an AdInsight account number, a pool id, a public phone number); they export
with normal config.

## How the tracking script is attached

`adinsight_clarity_page_attachments(&$page)` in `adinsight_clarity.module`:

```php
$id = \Drupal::config('adinsight_clarity.settings')->get('account');
if (!empty($id)) {
  $page['#attached']['library'][] = 'adinsight_clarity/adinsight_clarity';
  $page['#attached']['drupalSettings']['adinsight_clarity'] = ['account' => (string) $id];
}
```

Library `adinsight_clarity/adinsight_clarity` (`adinsight_clarity.libraries.yml`, `header: true`)
loads `js/adinsight_clarity.js` with deps `core/jquery`, `core/drupal`, `core/drupalSettings`,
`core/once`. The behavior sets `window.adiInit` from `drupalSettings.adinsight_clarity.account`
and injects the vendor tracker `rTapTrack.min.js` from `static-ssl.responsetap.com` (over HTTPS)
or `static-cdn.responsetap.com` (over HTTP). The script loads on **every** page while an account
is configured, including admin pages and authenticated sessions — disclose it in your privacy /
cookie policy and consent-gate if required in your jurisdiction.

## The rendered number: `_adinsight_clarity_build_tag()`

Central builder in `.module`, statically cached. Returns nothing until both `pool` and `base_phone`
are set, else:

```php
['#theme' => 'adinsight_clarity_tag', '#pool' => $pool, '#base' => $base]
```

`hook_theme()` registers `adinsight_clarity_tag` with variables `pool`, `base`, `tag` (default
`span`). `template_preprocess_adinsight_clarity_tag()` adds classes `tel-number` and
`adinsightNumber{pool}`; if `tag == 'a'` it sets `href = 'tel:' . $base`. Template:

```twig
{# templates/adinsight-clarity-tag.html.twig #}
<{{ tag }}{{ attributes }}>{{ base }}</{{ tag }}><span>*</span>
```

The AdInsight JavaScript finds the `adinsightNumber{pool}` element and rewrites its text to the
pooled number; the `<span>*</span>` is a marker. All four placement methods below ultimately
render this same array.

## Four ways to place the number

1. **Block** — `Plugin\Block\AdinsightClarityBlock` (id `adinsight_clarity_block`, admin label
   *"AdInsight Clarity Telephone Number"*). `build()` returns `_adinsight_clarity_build_tag()`.
   Place it in any region via *Structure → Block layout*.

2. **Filter** — `Plugin\Filter\AdinsightClarityFilterTag` (id `adinsight_clarity_filter_tag`, type
   `TYPE_TRANSFORM_IRREVERSIBLE`). Enable *"AdInsight Telephone Tag"* on a text format; then any
   literal `<adinsight />` (or `<adinsight/>`) in that field is replaced with the span. Internally
   `prepare()` turns `<adinsight />` into the placeholder `[adinsight-tag]` and `process()`
   `str_replace`s it with the rendered markup.

3. **Token** — `adinsight_clarity.tokens.inc` registers token type `adinsight_clarity` with tokens
   `account`, `pool`, `base-number` (scalar config values, `Html::escape`d when `sanitize` is on)
   and `tag` (the rendered span via the renderer service). Usable anywhere tokens are supported;
   the token *browser UI* requires the contrib `token` module.

4. **Manual HTML** — copy the exact `<span>` shown in the settings form's *Usage → Manual HTML*
   section into a Twig template or content. Re-copy it if you later change `pool` or `base_phone`.

## Operating notes

- Nothing renders and no script loads until `account` (for the script) and `pool` + `base_phone`
  (for the span) are configured.
- Changing `pool`/`base_phone` invalidates the static cache on save, but any **hard-coded** manual
  spans in templates/content must be updated by hand.
- HTTP vs HTTPS host for the vendor script is chosen at runtime by `document.location.protocol`.
