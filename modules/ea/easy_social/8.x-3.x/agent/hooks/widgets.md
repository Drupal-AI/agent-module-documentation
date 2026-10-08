# Extending Easy Social (widget hook API)

Easy Social's widgets are **not** a Drupal plugin type — they are collected through classic alter/
invoke hooks in `easy_social.module`. `easy_social_get_widgets()` calls
`\Drupal::moduleHandler()->invokeAll('easy_social_widget')` then `->alter('easy_social_widget', …)`,
statically caching the merged list. The list is what the global settings form offers as checkboxes and
what `easy_social_preprocess_easy_social()` iterates when rendering.

## `hook_easy_social_widget()`

Return an array of widget definitions keyed by machine name. Each definition:

| Key | Required | Meaning |
|---|---|---|
| `name` | yes | Human label (admin UI only). |
| `js` | no | An asset library id (e.g. `mymodule/mywidget`) attached when the widget renders. |
| `css` | no | An asset library id attached when the widget renders. |

For each widget you must also define a **theme hook** named `easy_social_<machine_name>` (via
`hook_theme()`) with a matching template `easy-social-<machine-name>.html.twig`. The default widgets
(`easy_social_easy_social_widget()`) map `twitter`/`facebook`/`linkedin`/`pinterest` to the
`easy_social/*` libraries; `email` defines no library.

```php
function mymodule_easy_social_widget() {
  return [
    'mastodon' => [
      'name' => t('Mastodon'),
      'js' => 'mymodule/mastodon',   // optional asset library id
      // 'css' => 'mymodule/mastodon_css',
    ],
  ];
}

function mymodule_theme() {
  return ['easy_social_mastodon' => ['variables' => []]];
}
```

Every `easy_social_*` theme hook automatically gets `_easy_social_preprocess_widget()` prepended to
its preprocess chain by `easy_social_theme_registry_alter()`. That helper injects, into your template
variables: `async` (bool from `easy_social.settings:global.async`), `url` (`$base_url . Url::fromRoute('<current>')`
— the current page URL), and `lang` (defaults to `'en'`). The intended `title` variable is a
commented-out `@todo` and is **not** provided.

## `hook_easy_social_widget_alter(&$widgets)`

Change definitions others declared — e.g. `$widgets['facebook']['name'] = 'FB';` or unset a widget.
Runs after all `hook_easy_social_widget()` implementations.

## `hook_easy_social_supported_entity_alter(&$entity_types)`

`easy_social_get_supported_entities()` seeds the list with `comment`, `file`, `node`, `taxonomy_term`,
`user` and then runs `->alter('easy_social_supported_entity', $entity_types)`. Add (or remove) entity
type ids here to control which entities receive the `easy_social` extra display field (see
[../configure/settings.md](../configure/settings.md)).

```php
function mymodule_easy_social_supported_entity_alter(array &$entity_types) {
  $entity_types[] = 'media';
}
```

## Reference: the `easy_social_example` submodule

`contrib/easy_social_example/` is a worked example (package `Examples`, dependency
`easy_social:easy_social`, not enabled by default). It:

- declares widget `example` via `easy_social_example_easy_social_widget()` (name only, no library);
- registers theme hook `easy_social_example` + template `easy-social-example.html.twig`;
- builds an `example_share_link` (`Link::fromTextAndUrl` to `http://www.example.com/share`) in
  `easy_social_example_preprocess_easy_social_example()`;
- ships its own settings form `SettingsForm` (id `easy_social_example_settings`, config
  `easy_social.example`) at route `easy_social_example.settings`
  (`/admin/config/services/easy-social/example`, permission `administer easy_social`).

Note the example's `submitForm()` uses the legacy `$form_state['values'][...]` array access and
`$this->configFactory->get(...)->set(...)` on a read-only config object — illustrative only; use
`$form_state->getValue()` and `getEditable()`/`$this->config()` in real code.
