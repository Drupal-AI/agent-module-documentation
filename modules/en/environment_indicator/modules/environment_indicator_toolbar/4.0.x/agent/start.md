# environment_indicator_toolbar — agent start

Submodule of **environment_indicator**. Tints the core admin **toolbar** background/text
with the active environment's colors. Depends on core `toolbar` +
`environment_indicator`. No config or permissions of its own.

Enable it (`drush en environment_indicator_toolbar`) and set an active environment — see the
parent module's `configure/settings.md`. Toggled by the parent `toolbar_integration` setting;
just adds a toolbar CSS/JS library (`css/toolbar.css`, `js/toolbar.js`) and marker images.
No solution docs needed.
