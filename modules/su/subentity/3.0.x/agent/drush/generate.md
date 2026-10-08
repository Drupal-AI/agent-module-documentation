# Drush generator: `drush generate subentity`

The module registers one DrupalCodeGenerator generator,
`Drupal\subentity\Drush\Generators\SubEntityGenerator`:

- Generator name `entity:subentity`, alias **`subentity`**, type `MODULE_COMPONENT`.
- Run it with `drush generate subentity` (Drush 12+ auto-discovers generators under
  `src/Drush/Generators`; no `drush.services.yml`).
- Unlike `drush generate content-entity`, it does **not** create a new module — the generated files
  are written into an **existing** module you name. A subentity lives in the parent entity's module.

## Interview questions (in order)

1. Machine name (of the target module)
2. Name (module name)
3. Entity label — default `{name}`
4. Class name — default `{label|camelize}`
5. Has bundle? — default **No**
6. Make this entity translatable? — default **Yes**
7. Make this entity revisionable? — default **Yes**
8. With twig template? — default **No**
9. Create hook_update_N for subentity install? — default **Yes**

Answer non-interactively by passing `--answer` in question order, e.g. (from the README):

```bash
drush generate subentity --answer='mymodule' --answer='Mymodule' \
  --answer='My Entity' --answer='MyEntity' --answer='No'
```

## Files produced

| File | When | Contents |
|---|---|---|
| `src/Entity/{Class}.php` | always | Content entity extending `SubEntityBase`, with the subentity handlers pre-wired and a `title` base field. |
| `{machine_name}.links.menu.yml` | always (prepend) | Collection + structure menu links under `subentity.admin.structure.types`. |
| `{machine_name}.links.task.yml` | always (prepend) | Local tasks. |
| `{machine_name}.routing.yml` | always (prepend) | `entity.<name>.collection` route requiring `administer subentities`. |
| `src/Entity/{Class}Type.php` | if **Has bundle** | Companion `ConfigEntityBundleBase` (`..._type`) wired to `BundleListBuilder` / `BundleForm` / `BundleHtmlRouteProvider`. |
| `config/schema/{name}_type.yml` | if bundle | Config schema for the bundle config entity. |
| `{machine_name}.links.action.yml` | if bundle | "Add bundle" action link. |
| `{twig_name}.html.twig` | if **template** | Copy of the module's `subentity.html.twig`. |
| `{machine_name}.install` | if **install** | `hook_update_N` calling `SubentityHelper::installSubentity('{name}')` (append). |

After generating, install the entity schema: run `drush updb` (executes the generated
`hook_update_N`) — or, if you skipped the install hook, call
`SubentityHelper::installSubentity()` yourself (see api/framework.md). Generated CRUD routes live
under `/admin/content/<name>` and, for bundles, `/admin/structure/subentities/<name>_type`.
