# Add & configure the Entity handler

There is no site-wide config page. The handler is attached **per webform**.

## Via the UI

1. Go to *Structure → Webforms*, edit a webform, open *Settings → Emails / Handlers*.
2. *Add handler* → choose **Entity** (category "External").
3. *Entity settings*: pick the **Entity operation** (Create a new entity / Update entity ID stored
   in an element / Update custom entity ID), the **Entity type** (bundle), optionally a
   *Load by properties* YAML map, and `skip_if_exists`.
4. When you pick an Entity type, the **Entity values** fieldset AJAX-reloads with one details
   group per field; for each property choose a submission element, `Null`, or a custom value.
5. *Additional settings → Execute*: tick the submission states that should trigger it (default:
   when submission is completed).
6. Save.

## Via config / drush

State lives in `webform.webform.<id>` under `handlers`. Create a handler instance with the webform
handler manager and add it to the webform:

```bash
drush php:eval '
  $webform = \Drupal\webform\Entity\Webform::load("my_form");
  $handler = \Drupal::service("plugin.manager.webform.handler")->createInstance(
    "webform_entity_handler", [
      "id" => "webform_entity_handler",
      "handler_id" => "create_article",
      "label" => "Create Article",
      "status" => TRUE,
      "weight" => 0,
      "settings" => [
        "operation" => "_default",          // create new
        "entity_type_id" => "node:article", // <type>:<bundle>
        "entity_values" => [
          "title" => ["value" => "input:subject"],
          "body"  => ["value" => "input:message"],
        ],
        "states" => ["completed"],
      ],
    ]);
  $webform->addWebformHandler($handler);
  $webform->save();
'
```

Read back which handlers a webform has: `$webform->getHandlers()` (iterate; each handler's
`getPluginId()` and `getSettings()`), or inspect the exported `webform.webform.<id>.yml` `handlers`
key. `drush config:get webform.webform.<id> handlers` also shows it.
