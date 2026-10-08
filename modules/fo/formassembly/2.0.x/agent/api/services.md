# Services & public API

Declared in `formassembly.services.yml`. All extend `ApiBase` except where noted; `ApiBase::getUrl($segment)`
builds a `Url` against the configured `endpoint` (`base`, `api`, `forms`, or an arbitrary path segment).

## `formassembly.sync` — `Drupal\formassembly\ApiSync`
Pulls the form catalog and reconciles `fa_form` entities.
- `getForms(string $id = ''): bool` — GETs `/api_v1/forms/index.json` (or `/admin/api_v1/...` when
  `admin_index` is set, paging `show=50` per page) with the OAuth token as an `access_token` query
  param. Caches paged results in the `fasync` bin keyed by `$id`; returns TRUE when finished.
- `syncForms(string $id = ''): void` — for each returned form, loads the `fa_form` by `faid` and
  updates name/modified when newer, or creates a new entity; then `disableInactive()` archives forms
  no longer present. Names are run through `Xss::filter(Html::decodeEntities(...))`.

## `formassembly.markup` — `Drupal\formassembly\ApiMarkup`
Fetches a single form's HTML for rendering.
- `getFormMarkup(FormAssemblyEntity $entity): string` — GETs `/rest/forms/view/{faid}`. Adds the
  entity's `query_params` as pre-fill query params, running each value through the Token service
  (`user` plus any content entity in the current route parameters as token data), and invoking
  `hook_formassembly_form_params_alter()`. Returns the raw form HTML (or a `wFormFailed` div on error).
  No access_token is sent on this endpoint.
- `getNextForm(string $tfa_next): string` — GETs `/rest/{urldecoded tfa_next}` to follow FormAssembly's
  multi-page `tfa_next` continuation and returns its HTML.

## `formassembly.authorize` — `Drupal\formassembly\ApiAuthorize`
OAuth handling (see [../configure/settings.md](../configure/settings.md)).
- `authorize(string $code): void` — `authorization_code` grant; stores the League `AccessToken` in State
  `fa_form.access_token`.
- `getToken(): string` — returns the current token, refreshing via `refresh_token` grant when expired.
- `isAuthorized(): bool` — TRUE when a non-expired token exists.

## `formassembly.key` — `Drupal\formassembly\FormAssemblyKeyService`
- `getOauthKeys(): array` — resolves `['cid' => ..., 'secret' => ...]` from either the plain
  `formassembly.api.oauth` config or, when `provider` is `key`, from the referenced Key entity.
- `additionalProviders(): bool` — TRUE when the Key module's repository was injected
  (`@?key.repository`, conditional).

## `formassembly.batch` — `Drupal\formassembly\FormAssemblyBatchProcessor`
Shared batch logic used by the settings form, Drush, and Console: `configureBatch()` (assigns a UUID
sync id), `iterateBatch()` (one `getForms()` page), `batchPostProcess()` (calls `syncForms()`).

## Supporting services
- `logger.channel.formassembly` — logger channel `formassembly`.
- `cache.fasync` — dedicated cache bin used to hold paged sync results.
- `formassembly.html_response.attachments_processor` — **decorates** core
  `html_response.attachments_processor` to render the JS/CSS extracted from a FormAssembly form's
  `<head>` into the page.
