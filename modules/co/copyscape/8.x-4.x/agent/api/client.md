<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Copyscape — API client and the check/validate flow

## Service `copyscape.api` → `Drupal\copyscape\Copyscape\Api` (`src/Copyscape/Api.php`)
Constructed with `@config.factory` and `@http_client` (Guzzle).

- `textSearchInternet($text, $encoding = 'UTF-8', $full = 5)` — convenience wrapper called by the
  node validation flow; delegates to `textSearch()`.
- `textSearch($text, $encoding, $full, $operation = 'csearch')` — assembles params (`e` encoding,
  `c` search depth when non-empty) and calls `apiCall()` with the text as POST data and an XML spec
  that maps repeated `result` elements to an array.
- `apiCall($operation, $params, $xmlSpec, $postData)` — reads `copyscape.settings`
  (`api_url`, `api_user`, `api_key`) and `copyscape.content` (`site_ignore`). Returns `FALSE`
  immediately if `api_user` or `api_key` is empty. Builds the query
  `u`=user, `k`=key, `o`=operation, `i`=site_ignore (+ merged `$params`) with `http_build_query()`,
  appends it to `api_url` as `"{$url}?{$query}"`, and sends it via `$httpClient->get($url)` when
  there is no POST body or `$httpClient->post($url, ['body' => $postData])` when there is. Non-200
  responses return `FALSE`; otherwise the body is parsed by `readXml()`.
- `readXml($xml, $spec)` / `xmlStart()` / `xmlEnd()` / `xmlData()` — a hand-rolled
  `xml_parser_create()` based parser that turns the Copyscape XML reply into a nested PHP array
  (keys lower-cased; elements named in `$spec` become numeric arrays). Returns `FALSE` on parse
  failure.

## Service `copyscape.utility` → `Drupal\copyscape\Copyscape\Utility` (`src/Copyscape/Utility.php`)
Constructed with `@config.factory`, `@entity_type.manager`, `@current_user`.
- `userCanBypass($user)` — true if the user id is in `users_bypass` or the user has a role flagged
  in `roles_bypass`.
- `isCopyscaped($bundle, $field = NULL)` — true if checking is enabled (`reject_content` and
  `reject_value` set) and the bundle/field is selected in `copyscape_ct.<bundle>`.
- `copyscapedFields($bundle)` — returns the selected field names plus any
  `copyscape_ct_para_field<bundle>` Paragraph path.
- `wasSuccessful(array $response)` — returns `TRUE` (pass) when there is no `result`, otherwise scans
  each `result`; if `reject_content` is on and a `percentmatched` is strictly greater than
  `reject_value`, returns that result array (a "fail" signal).
- `updateUserFails()` / `resetUserFails()` / `failsCapped($fails)` — maintain the `copyscape_fail`
  counter and compare against `copyscape.settings.failures`.
- `saveResults($results, $nid)` — persists a `copyscape_result` entity only when `logs` is enabled.

## The validate flow (`copyscape.module`)
1. `copyscape_form_alter()` matches node add/edit form ids, returns early if
   `Utility::userCanBypass()` or the bundle is not selected, else appends `copyscape_form_validate`
   to `$form['#validate']`.
2. `copyscape_form_validate()` re-checks role bypass, resolves the checked fields (including nested
   Paragraph subforms via the `parent/para:field:i` path parsing), and for each field calls
   `copyscape___text_search_online_and_validate(strip_tags($value), …)`.
3. That helper calls `Api::textSearchInternet()`, then `Utility::wasSuccessful()`. On a match it
   increments the user's fail count and builds a message containing the matched `url`,
   `percentmatched` and `viewurl` via `t()` placeholders (auto-escaped); it either sets a blocking
   `setErrorByName()` error or (when `show_plag_check_as_warning`) a warning. If the fail cap is
   reached (`failsCapped()`), it resets the counter, calls `$user->block()` + `$user->save()` and
   `user_logout()`.
4. `copyscape_node_insert/update()` call `Utility::saveResults()` to log the collected responses.

## Operating notes
- No Drush commands and no queue: checks run synchronously inside form validation, so each checked
  field is one blocking Copyscape API request during node save.
- Every request consumes Copyscape Premium credits; combine Paragraph fields (omit `:i`) to reduce
  calls, or check individually (`:i`) for accuracy.
- If credentials are unset, `apiCall()` returns `FALSE` and validation passes silently (no check).
