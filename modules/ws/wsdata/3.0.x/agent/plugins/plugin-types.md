# Plugin types: connector / decoder / encoder

WSData composes three annotation-based plugin types. A WSServer picks one **connector**
(transport); a WSCall picks one **decoder** (response parsing) and one **encoder** (request
body). There is no separate "replacement" plugin — replacements are handled inside
`WSConnectorBase` (`applyReplacements()` = literal `[name]` replace + Drupal token service).

| Plugin type | Manager service | Directory | Annotation | Interface / base | Alter hook |
|---|---|---|---|---|---|
| Connector | `plugin.manager.wsconnector` | `Plugin/WSConnector` | `@WSConnector` | `WSConnectorInterface` / `WSConnectorBase` | `wsdata_wsconnector_info` |
| Decoder | `plugin.manager.wsdecoder` | `Plugin/WSDecoder` | `@WSDecoder` | `WSDecoderInterface` / `WSDecoderBase` | `wsdata_wsdecoder_info` |
| Encoder | `plugin.manager.wsencoder` | `Plugin/WSEncoder` | `@WSEncoder` | `WSEncoderInterface` / `WSEncoderBase` | `wsdata_wsencoder_info` |

## Built-in plugins

**Connectors** (`src/Plugin/WSConnector/`):

| id | Transport / notes |
|---|---|
| `WSConnectorSimpleHTTP` | Guzzle HTTP. Methods get/patch/post/put/delete/head/options. Only `get` is cacheable. Per-server options: path, method, headers, expires, `skip_verify_ssl`. |
| `WSConnectorSimpleHTTPWithLangReplacement` | HTTP + replaces `[LANGUAGE]` in URL/path with a per-langcode value based on current content language. |
| `WSConnectorGraphQL` | HTTP POST; sends `{query, operationName, variables}` JSON; forces `Content-Type: application/json`; `[LANGUAGE]` = uppercased langcode. |
| `WSConnectorSOAP` | PHP `\SoapClient`. Methods create/read/update/delete/index. Options: user, key (password), wsdl, method. |
| `WSConnectorLocalFile` | Reads/writes a local file at `endpoint/filename`. Methods read/write/append. |

**Decoders** (`src/Plugin/WSDecoder/`): `WSDecoderJSON` (`text/json`), `WSDecoderXML`
(`text/xml`, via `SimpleXMLElement`), `WSDecoderString` (pass-through). `wsdata_extras` adds
`WSDecoderJSONList` (flattens a list into markup with a `markup_element/key:path` key syntax).
`wsdata_example` adds `ExampleBlockDecoder`.

**Encoders** (`src/Plugin/WSEncoder/`): `WSEncoderJSON` (json_encode the body),
`WSEncoderString` (pass-through).

## Add a connector

```php
namespace Drupal\my_module\Plugin\WSConnector;

use Drupal\wsdata\Plugin\WSConnectorBase;

/**
 * @WSConnector(
 *   id = "MyConnector",
 *   label = @Translation("My connector", context = "WSConnector"),
 * )
 */
class MyConnector extends WSConnectorBase {
  public function getMethods() { return ['get']; }
  public function getOptions() { return ['path' => '']; }
  public function getReplacements(array $options) {
    return $this->findTokens($this->endpoint . '/' . $options['path']);
  }
  public function getOptionsForm($options = []) {
    return ['path' => ['#type' => 'textfield', '#title' => $this->t('Path')]];
  }
  public function call($options, $method, $replacements = [], $data = NULL, array $tokens = []) {
    $uri = $this->applyReplacements($this->endpoint . '/' . $options['path'], $replacements, $tokens);
    // …perform request, on failure $this->setError($code, $msg); return FALSE;
    return $body_string;
  }
}
```

Extend `WSConnectorSimpleHTTP` instead of `WSConnectorBase` to reuse the Guzzle request,
caching and header handling (that is how the SOAP/GraphQL/Lang connectors are built). Override
`supportsCaching()` / `expires()` to control result caching, and `getCache()` to add a
per-variant cache key (the language connectors return the langcode).

## Add a decoder

Extend `WSDecoderBase`, annotate `@WSDecoder`, implement `decode($data)` (return an
array/string). Optionally override `accepts()` (content types), `isCacheable()`, and
`getData($key, $lang)` (the `:`-path selector).

## Add an encoder

Extend `WSEncoderBase`, annotate `@WSEncoder`, implement
`encode(&$data, &$replacement, &$url)` (mutate `$data` in place).
