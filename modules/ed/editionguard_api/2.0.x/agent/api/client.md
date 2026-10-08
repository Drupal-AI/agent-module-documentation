<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# editionguard_api — client & endpoint plugins

Get the service and call an endpoint plugin:

```php
$client = \Drupal::service('editionguard_api.client');
$manager = $client->getEndpointPluginManager();
$endpoint = $manager->createInstance('book_list');
$result = $client->request($endpoint, $query_params, $form_params);
```

`request()` returns the decoded JSON array on HTTP 200/201, otherwise `[]`.
OAuth endpoints add the cached token header automatically; `book_create`,
`book_update`, `book_replace` send multipart (the `resource` form value is
opened as a file stream).

Endpoint plugin ids: `book_list`, `book_get`, `book_create`, `book_update`,
`book_replace`, `book_delete`, `book_generate_links`, `master_link_list/get/
create/update/replace/delete`, `transaction_list/get/create/delete`,
`deliver_book_link`, `deliver_book_links`, `download_list`.
