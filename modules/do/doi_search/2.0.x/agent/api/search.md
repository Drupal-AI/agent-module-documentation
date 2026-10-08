<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DOI search page & the doi_search.manager service

## Install & enable

```bash
composer require drupal/doi_search
drush en doi_search -y
```

No module or library dependencies, no config to import. Grant the permission (below), then use
`/doi-search`. The site's PHP process needs outbound HTTP access to Crossref.

## Route & permission

`doi_search.routing.yml`:

```yaml
doi_search.page:
  path: '/doi-search'
  defaults:
    _title: 'Search Publications'
    _controller: '\Drupal\doi_search\Controller\DoiSearchController::build'
  requirements:
    _permission: 'access doi search'
```

Single permission from `doi_search.permissions.yml`: **`access doi search`** ("Access Doi Search").
It has no `restrict access: TRUE`, so it is an ordinary permission — not granted to anonymous by
default. Manage it at `/admin/people/permissions/module/doi_search`. There is no admin/settings
route; `configure` is null.

## The search form

`SearchForm` (`src/Form/SearchForm.php`, form id `doi_search_search`) is a standard `FormBase`:

- a **required** `search` textfield labelled *DOI*, default-valued from the `doi` query param;
- on submit, `submitForm()` does **not** call the API — it just
  `setRedirect('doi_search.page', [], ['query' => ['doi' => $doi]])`, i.e. it reloads the page as a
  GET with `?doi=<value>`. The lookup itself is driven by that query param, so a direct
  `GET /doi-search?doi=10.1000/xyz` works without posting the form.

## The controller

`DoiSearchController::build()` (`src/Controller/DoiSearchController.php`):

1. builds the `SearchForm`;
2. reads `$doi = request->query->get('doi')`;
3. if non-empty, calls `doiSearchManager->getData($doi)`; when the returned record has a `DOI`
   property it decorates it:
   - `formattedAuthors` via `formatAuthors()` (joins `given family`, or falls back to `author->name`);
   - `pdf` via `getPdfLink()` (first `link[].URL` ending in `pdf`);
   - `date_text` / `date_time` from `created['date-time']` (`date("d M Y", strtotime(...))`);
4. renders the record with `#theme => 'doi_search_result'`;
5. builds cited references with `getPublicationReferences()`: each `reference[]` with its own `DOI`
   triggers a **second** `getData()` call (via `getReferenceData()`) to resolve title/author/year/url;
   references without a DOI are rendered from the inline fields. `getPublicationTitle()` picks the
   first array key containing `title` (excluding `container-title`).
6. returns `#theme => 'doi_search_page'` with `form`, `result`, `references`, and `empty` flags.

Note each cited reference that carries a DOI makes its own Crossref request, so one page view can
fan out to many outbound calls.

## The service — DoiSearchManager

`doi_search.services.yml`:

```yaml
services:
  doi_search.manager:
    class: Drupal\doi_search\DoiSearchManager
    arguments: ["@messenger", "@http_client"]
```

`DoiSearchManager::getData($doi)` (`src/DoiSearchManager.php`) builds the request URL by
concatenating the DOI onto a fixed Crossref base, issues a Guzzle `GET` with
`['http_errors' => FALSE]`, `json_decode`s the body and returns `$data->message ?? []`. On an
exception it adds a translated "Error retrieving Doi data" messenger error and returns void. The
returned value is a `stdClass` (or `[]`) — the raw Crossref `message` object; the caller is
responsible for reading fields like `title`, `author`, `abstract`, `URL`, `link`, `reference`,
`created`.

Call it from custom code:

```php
$data = \Drupal::service('doi_search.manager')->getData('10.1000/xyz123');
// $data->title, $data->author, $data->URL, ...
```

The companion `doi_field` module depends on `doi_search` and calls this same method.

## Templates (hook_theme in doi_search.module)

- `doi_search_page` (`templates/doi-search-page.html.twig`) — wrapper: prints the form, then, when a
  DOI was submitted, the result or a "No results found" message, then the references list.
- `doi_search_result` (`templates/doi-search-result.html.twig`) — one publication: title, authors,
  date `<time>`, abstract, container/volume, external URL link, optional PDF link, type.
- `doi_search_reference` (`templates/doi-search-reference.html.twig`) — one cited reference: title,
  author, year, DOI, URL link.

All three receive a single `items` variable. To customise output, override these templates in your
theme (copy from `templates/` and clear caches).

## Operating notes

- Works immediately after enable + granting `access doi search`; no configuration.
- Requires outbound network access from the web server to the Crossref API.
- `hook_help()` shows `README.md` on the module's help page; if the `markdown` module is enabled it
  renders as HTML, otherwise as `<pre>` text.
