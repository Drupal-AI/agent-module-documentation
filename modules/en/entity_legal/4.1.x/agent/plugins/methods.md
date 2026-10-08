# EntityLegal acceptance-method plugins

Plugin type that decides **how** a required document is presented to a user. Manager
`plugin.manager.entity_legal` (`EntityLegalPluginManager`), namespace `Plugin/EntityLegal`, interface
`EntityLegalPluginInterface`, base `EntityLegalPluginBase`, annotation `@EntityLegal`, alter hook
`entity_legal_methods` (see hooks doc). Each plugin declares a `type`: `new_users` or `existing_users`;
that type determines which document setting (`require_signup` vs `require_existing`) it services and which
`require_method` select it appears in.

## Shipped plugins (`src/Plugin/EntityLegal/`)

| id | type | Behaviour | Invoked from |
|---|---|---|---|
| `message` | existing_users | Adds a status message prompting acceptance on every page. | `entity_legal_preprocess_page()` |
| `popup` | existing_users | jQuery-UI modal (library `entity_legal/popup`) shown on all pages until accepted; renders the published version markup into `drupalSettings.entityLegalPopup`. | `entity_legal_page_attachments_alter()` |
| `redirect` | existing_users | Forces the user to an acceptance page (postpones/restores messages via private tempstore). | event subscriber |
| `form_link` (ProfileForm) | new_users | Adds an acceptance checkbox linking to the document on the user register form. | `entity_legal_form_user_register_form_alter()` |
| `form_inline` (ProfileFormEmbedded) | new_users | Embeds the acceptance form inline in the register form. | `entity_legal_form_user_register_form_alter()` |

## Annotation

```php
/**
 * @EntityLegal(
 *   id = "popup",
 *   label = @Translation("Popup on all pages until accepted"),
 *   type = "existing_users",   // or "new_users"
 * )
 */
```

## Writing a method plugin

Extend `EntityLegalPluginBase` and implement `execute(array &$context = [])`. Put it in
`Drupal\<mymodule>\Plugin\EntityLegal`.

```php
#[\Drupal\entity_legal\Annotation\EntityLegal] // or the @EntityLegal doc-block annotation
class EmailMethod extends EntityLegalPluginBase {
  public function execute(array &$context = []): void {
    foreach ($this->getDocumentsForMethod() as $document) {
      // $document is a published, not-yet-accepted document that selected THIS plugin id.
    }
  }
}
```

Key helper on the base class: `getDocumentsForMethod()` returns the published documents that (a) require
this plugin's `type`, (b) selected this plugin id as their `require_method`, and (c) the current user has
not yet accepted — and it returns **empty** for users holding `administer entity legal` or
`bypass entity legal acceptance`, and for `existing_users` methods when the user is anonymous. `$context`
is passed differently per invocation (e.g. `['attachments' => &$attachments]` for popup,
`['form' => &$form]` for register-form methods).

The plugin id you define becomes selectable in the document's New/Existing users `require_method` select
(filtered by `type`). Register no services — the manager autodiscovers the plugin.
