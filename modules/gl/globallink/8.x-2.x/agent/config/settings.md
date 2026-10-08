<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GlobalLink — translator settings & config

There is **no dedicated settings page**. `globallink.info.yml` declares `configure: globallink.admin`
but the module ships **no `*.routing.yml`**, so that route does not exist. Configuration is done by
creating a **TMGMT translator** entity of plugin type `globallink` (Translation → Providers →
Add translator, or `/admin/tmgmt/translators`). Settings are stored on the translator config entity
under `settings.*` and validated live against the GlobalLink API.

## Install / enable

```
composer require drupal/globallink      # pulls tmgmt, tmgmt_file, and globallink-connect-api-php:4.18.6
drush en globallink -y
```
Requires the PHP `soap` extension — `globallink_requirements()` (`globallink.install`) raises
`REQUIREMENT_ERROR` at install/runtime if `extension_loaded('soap')` is false. `GlExchangeAdapter`
loads translator `globallink` by machine name, so name the translator entity **`globallink`**.

## Config object & schema

Config type **`tmgmt.translator.settings.globallink`** (`config/schema/globallink.schema.yml`,
extends `tmgmt.translator_base`). Keys stored on the translator's `settings`:

| Key | Type | Meaning |
|-----|------|---------|
| `pd_url` | string | GlobalLink Project Director API base URL (a trailing `/` is stripped in `GlExchangeAdapter::getPDConfig()`). |
| `pd_username` | string | GlobalLink username (also the default submitter). |
| `pd_password` | string | GlobalLink password. |
| `pd_projectid` | string | Project id (the config form accepts a comma-separated list and rejects duplicates). |
| `pd_submissionprefix` | string | Prefix prepended to the submission name (`prefix . $job->label()`). |
| `pd_classifier` | string | GlobalLink file-format classifier; must be one of the project's `fileFormats`. Not in the schema but read/written by the form. |
| `pd_notify_emails` | string | Comma/space-separated emails for TMGMT-message notifications; blank disables. |
| `pd_combine` | string | If truthy, all job items go into one XLIFF document; else one document per item. |
| `pd_due_date_offset` | string | Default due-date offset in working days (defaults to `3`). |
| `pd_notify_level` | sequence | TMGMT message levels to email: `status`, `debug`, `warning`, `error`. |
| `pd_user_agent` | select | Environment reported to Project Director: `dev` / `test` / `stage` / `prod`. |

`GlExchangeAdapter::getDefaultSettings()` also seeds `pd_classifier`, `pd_agent` (`'Drupal 8'`) and
`pd_user_agent` (`'prod'`). `GlobalLinkTranslator::defaultSettings()` forces `xliff_cdata = TRUE`
(CDATA encoding in the tmgmt_file XLIFF export).

## Config form — `GlobalLinkTranslatorUi::buildConfigurationForm()`

Renders the fields above (`pd_url` as `url`, `pd_password` as `password`, notify levels as
checkboxes, environment as a select). `pd_url`, `pd_username`, `pd_password`, `pd_projectid`,
`pd_submissionprefix`, `pd_classifier` are `#required`.

`validateConfigurationForm()` performs a **live API round-trip** through
`globallink.gl_exchange_adapter`:
- builds a `\PDConfig` from the entered URL/username/password/user-agent and constructs a
  `\GLExchange` (which authenticates during construction);
- calls `getProject()` for each project id, collects the project's `fileFormats`, and errors on
  **duplicate project ids** or a **classifier not offered by the project**;
- flattens `GlobalLinkTranslator::getSupportedLanguagePairs()` (from the project's
  `languageDirections`) and errors on remote-language mappings the project does not support;
- validates each notify email via `email.validator`;
- any thrown exception ⇒ form error *"Login credentials are incorrect."*

## Per-job checkout settings — `checkoutSettingsForm()`

For discrete jobs: `comment` (instructions), `due` (a `datetime`, defaulted to now + offset working
days, validated to be in the future by `validateDueDate()`), and `urgent` (checkbox). For
**continuous** jobs: `required_by` (working days) plus an **Exclusion filters** table
(`buildContinuousFilter()`) with AJAX "Add another filter"; each row is a field (`url` matches /
`id` equals) + value, consumed by the event subscriber.

## Operating notes

- `checkoutInfo()` adds a **"Pull translations"** button on active jobs → `submitPullTranslations()`
  → `GlobalLinkTranslator::fetchJobs($job)`.
- The vendor-side GlobalLink project must already define the language directions and classifiers you
  configure here; otherwise the form validation rejects them.
