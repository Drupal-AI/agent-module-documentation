# migrate_example_setup — agent start

Hidden helper (package Migration, `hidden: true`) for the `migrate_example` module.
Installs the destination content type, fields, taxonomy vocabulary and comment type the beer
migration writes into, and seeds the example source tables. Depends on core `comment`, `image`,
`text`, `options`, `taxonomy`. Pure scaffolding — enabled automatically as a dependency of
`migrate_example`, nothing runnable of its own, no config/plugins to document.
