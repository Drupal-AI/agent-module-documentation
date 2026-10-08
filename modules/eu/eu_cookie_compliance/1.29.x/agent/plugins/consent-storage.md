# ConsentStorage plugins

The module defines a **ConsentStorage** plugin type for recording a visitor's consent
server‑side (GDPR record‑keeping). It is managed by
`plugin.manager.eu_cookie_compliance.consent_storage`
(`src/Plugin/ConsentStorageManager.php`), annotation `@ConsentStorage`
(`src/Annotation/ConsentStorage.php`). Ships with `BasicConsentStorage`
(`src/Plugin/ConsentStorage/BasicConsentStorage.php`) which logs to the database.

## Implement one
Create `src/Plugin/ConsentStorage/MyConsentStorage.php`:

```php
namespace Drupal\my_module\Plugin\ConsentStorage;

use Drupal\eu_cookie_compliance\Plugin\ConsentStorageBase;

/**
 * @ConsentStorage(
 *   id = "my_consent_storage",
 *   name = @Translation("My consent storage"),
 * )
 */
class MyConsentStorage extends ConsentStorageBase {

  public function registerConsent($cid) {
    // Persist consent for the given consent id (e.g. to an external CRM).
  }

}
```

Select it via the `consent_storage_method` setting on the settings form. The chosen plugin's
`registerConsent()` is called when a visitor consents (posted to route
`eu_cookie_compliance.store_consent`, controller `StoreConsent::store`).
