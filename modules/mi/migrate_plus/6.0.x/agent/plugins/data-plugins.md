# The `url` source + data plugins

The `url` source (`Plugin/migrate/source/Url.php`) retrieves remote data through three
pluggable layers. Configure them by key in the source definition:

```yaml
source:
  plugin: url
  data_fetcher_plugin: http          # http | file
  data_parser_plugin: json           # json | json_subitem | xml | simple_xml | soap
  urls: 'https://api.example.com/items'
  item_selector: data/items          # parser-specific pointer into the payload
  headers:
    Accept: application/json
  authentication:                    # optional
    plugin: oauth2
    grant_type: client_credentials
    base_uri: https://api.example.com
    client_id: '...'
    client_secret: '...'
  fields:
    - name: id
      selector: id
    - name: title
      selector: title
  ids:
    id:
      type: integer
```

## Three plugin types this module DEFINES
Managers in `migrate_plus.services.yml`; base/interface/attribute in `src/`.

| Type | Namespace | Ships |
|---|---|---|
| `data_fetcher` | `Plugin/migrate_plus/data_fetcher` | `http`, `file` |
| `data_parser` | `Plugin/migrate_plus/data_parser` | `json`, `json_subitem`, `xml`, `simple_xml`, `soap` |
| `authentication` | `Plugin/migrate_plus/authentication` | `basic`, `digest`, `ntlm`, `oauth2` |

## Add your own (attribute-based)
```php
namespace Drupal\my_module\Plugin\migrate_plus\data_parser;

use Drupal\migrate_plus\Attribute\DataParser;
use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\migrate_plus\DataParserPluginBase;

#[DataParser(id: 'my_format', title: new TranslatableMarkup('My Format'))]
class MyFormat extends DataParserPluginBase {
  protected function openSourceUrl(string $url): bool { /* ... */ }
  protected function fetchNextRow(): void { /* set $this->currentItem */ }
}
```
`DataFetcher` and `Authentication` attributes follow the same pattern (id + title). Legacy
`@DataParser` / `@DataFetcher` / `@Authentication` annotations are still supported.

- `oauth2` requires `sainsburys/guzzle-oauth2-plugin`; `soap` requires PHP `ext-soap`.
- The `http` fetcher accepts Guzzle `request_options` (timeout, allow_redirects, …).
